import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/cubit/navigator_cubit.dart';
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/models/comment.dart';
import 'package:inprize/pages.dart';
import 'package:inprize/services/ad_service.dart';
import 'package:inprize/services/graph_api.dart';

part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final NavigatorCubit navigator;

  MediaCubit({required this.navigator}) : super(MediaInitial());

  Future<void> chooseWinner(AuthLoaded auth) async {
    // Display loading screen
    emit(MediaLoading(currentMedia: (state as MediaSelected).currentMedia));
    navigator.push(loadingPage);

    // Load comments list
    List<Comment> comments = await GraphApi.instance.getMediaComments(
      (state as MediaSelected).currentMedia.id,
    );

    // Check if publication has only one comment by user
    if (comments.length == 1 &&
        comments[0].username == auth.userData!.username) {
      emit(MediaError(
        currentMedia: (state as MediaSelected).currentMedia,
        errorMessage: "There are not enough comments to choose a winner",
      ));
      navigator.pop();
      return;
    }

    // Pick random comment
    final random = Random();
    var winner = comments[random.nextInt(comments.length)];
    while (winner.username == auth.userData!.username) {
      winner = comments[random.nextInt(comments.length)];
    }

    // Display results screen
    emit(MediaLoaded(
      currentMedia: (state as MediaSelected).currentMedia,
      comment: winner,
    ));
    navigator.replace(homePage);
    navigator.push(resultPage);
  }

  void selectMedia(IgMedia media) {
    emit(MediaSelected(currentMedia: media));
    navigator.push(mediaPage);
  }

  void closeMedia() {
    emit(MediaInitial());
    navigator.pop();
  }

  void closeResults() {
    closeMedia();
    AdService.instance.showInterstitial();
  }
}
