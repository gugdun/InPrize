import 'package:flutter/cupertino.dart';

class CountWidget extends StatelessWidget {
  final IconData icon;
  final int count;
  final double padding;
  final Color? color;

  const CountWidget({
    super.key,
    required this.icon,
    required this.count,
    this.color,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color ?? CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
        Padding(padding: EdgeInsets.only(left: padding)),
        Text(
          '$count',
          style: TextStyle(
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ),
      ],
    );
  }
}
