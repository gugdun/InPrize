import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/media_details/count_widget.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                (state as MediaLoaded).comment.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
            ),
            Text(
              state.comment.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CountWidget(
                icon: CupertinoIcons.heart,
                count: state.comment.likeCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
