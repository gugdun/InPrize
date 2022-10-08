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

  String _countToString(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000.0).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000.0).toStringAsFixed(1)}K';
    }
    return count.toStringAsFixed(0);
  }

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
          _countToString(count),
          style: TextStyle(
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ),
      ],
    );
  }
}
