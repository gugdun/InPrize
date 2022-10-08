import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/media_details/comment_caption.dart';
import 'package:inprize/widgets/media_details/count_widget.dart';

class MediaDetails extends StatelessWidget {
  const MediaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CupertinoTheme.of(context)
                  .textTheme
                  .textStyle
                  .color!
                  .withAlpha(25),
              blurRadius: 16,
              spreadRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: 260,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl:
                      (state as MediaSelected).currentMedia.thumbnailUrl ??
                          state.currentMedia.mediaUrl,
                  placeholder: (BuildContext context, String url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (BuildContext context, String url, _) =>
                      const Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                  fit: BoxFit.fitWidth,
                  memCacheWidth: 400,
                  maxWidthDiskCache: 400,
                ),
              ),
            ),
            if (state.currentMedia.caption != null &&
                state.currentMedia.caption!.isNotEmpty)
              CommentCaption(caption: state.currentMedia.caption!),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CountWidget(
                    icon: CupertinoIcons.heart,
                    count: state.currentMedia.likeCount,
                  ),
                  CountWidget(
                    icon: CupertinoIcons.bubble_right,
                    count: state.currentMedia.commentsCount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
