import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:inprize/cubit/navigator_cubit.dart';
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/models/comment.dart';
import 'package:inprize/services/graph_api.dart';

part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final NavigatorCubit navigator;

  MediaCubit({required this.navigator}) : super(MediaInitial());

  Future<void> chooseWinner() async {
    // Display loading screen
    emit(MediaLoading(currentMedia: (state as MediaSelected).currentMedia));
    navigator.push('/loading');

    // Load comments and pick random
    List<Comment> comments = await GraphApi.instance.getMediaComments(
      (state as MediaSelected).currentMedia.id,
    );
    final random = Random();
    final winner = comments[random.nextInt(comments.length)];

    // Display results screen
    emit(MediaLoaded(
      currentMedia: (state as MediaSelected).currentMedia,
      comment: winner,
    ));
    navigator.replace('/home');
    navigator.push('/result');
  }

  void selectMedia(IgMedia media) {
    emit(MediaSelected(currentMedia: media));
    navigator.push('/media');
  }

  void closeMedia() {
    emit(MediaInitial());
    navigator.pop();
  }
}
