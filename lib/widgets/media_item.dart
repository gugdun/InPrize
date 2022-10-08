import 'package:cached_network_image/cached_network_image.dart';
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
          child: CachedNetworkImage(
            imageUrl: media.thumbnailUrl ?? media.mediaUrl,
            placeholder: (BuildContext context, String url) =>
                const CupertinoActivityIndicator(),
            errorWidget: (BuildContext context, String url, _) => const Icon(
              CupertinoIcons.exclamationmark_circle,
              color: Color.fromRGBO(255, 0, 0, 1),
            ),
            fit: BoxFit.cover,
            memCacheWidth: 200,
            maxWidthDiskCache: 200,
          ),
        ),
      ),
    );
  }
}
