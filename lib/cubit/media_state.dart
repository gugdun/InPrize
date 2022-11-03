part of 'media_cubit.dart';

@immutable
abstract class MediaState {}

class MediaInitial extends MediaState {}

class MediaSelected extends MediaState {
  final IgMedia currentMedia;

  MediaSelected({required this.currentMedia});
}

class MediaError extends MediaSelected {
  final String errorMessage;

  MediaError({required super.currentMedia, required this.errorMessage});
}

class MediaLoading extends MediaSelected {
  MediaLoading({required super.currentMedia});
}

class MediaLoaded extends MediaLoading {
  final Comment comment;

  MediaLoaded({required super.currentMedia, required this.comment});
}
