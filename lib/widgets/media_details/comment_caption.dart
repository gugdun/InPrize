import 'package:flutter/cupertino.dart';

class CommentCaption extends StatelessWidget {
  final String caption;

  const CommentCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        caption,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
      ),
    );
  }
}
