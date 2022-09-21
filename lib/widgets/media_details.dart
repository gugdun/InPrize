import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';

class MediaDetails extends StatelessWidget {
  const MediaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 260,
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network((state as MediaSelected).currentMedia.mediaUrl),
            Text(state.currentMedia.caption),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
                Text('${state.currentMedia.likeCount}'),
                Icon(
                  CupertinoIcons.bubble_right_fill,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
                Text('${state.currentMedia.commentsCount}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
