import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacebookButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const FacebookButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/icons/facebook.svg'),
          child,
        ],
      ),
    );
  }
}
