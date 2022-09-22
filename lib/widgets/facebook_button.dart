import 'package:flutter/cupertino.dart';

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
          const Icon(
            IconData(0xe255, fontFamily: 'MaterialIcons'),
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child,
        ],
      ),
    );
  }
}
