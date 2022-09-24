import 'package:flutter/cupertino.dart';

class CommentCaption extends StatelessWidget {
  final String? caption;

  const CommentCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return caption != null
        ? Text(
            caption!.length > 25
                ? caption!.substring(0, 25).padRight(28, '.')
                : caption!,
            style: TextStyle(
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          )
        : Container();
  }
}
