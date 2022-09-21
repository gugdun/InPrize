import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:inprize/cubit/navigator_cubit.dart';
import 'package:inprize/models/ig_media.dart';

part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final NavigatorCubit navigator;

  MediaCubit({required this.navigator}) : super(MediaInitial());

  void selectMedia(IgMedia media) {
    emit(MediaSelected(currentMedia: media));
    navigator.push('/media');
  }

  void closeMedia() {
    emit(MediaInitial());
    navigator.pop();
  }
}
