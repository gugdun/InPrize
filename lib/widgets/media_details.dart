import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
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
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                (state as MediaSelected).currentMedia.mediaUrl,
              ),
            ),
            Text(
              state.currentMedia.caption,
              style: TextStyle(
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
