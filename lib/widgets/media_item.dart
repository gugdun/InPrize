import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/models/ig_media.dart';

class MediaItem extends StatelessWidget {
  final IgMedia media;

  const MediaItem({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) => Padding(
        padding: const EdgeInsets.all(1),
        child: GestureDetector(
          onTap: () => context.read<MediaCubit>().selectMedia(media),
          child: Image.network(
            media.thumbnailUrl ?? media.mediaUrl,
            fit: BoxFit.cover,
            cacheWidth: 200,
          ),
        ),
      ),
    );
  }
}
