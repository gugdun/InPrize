import 'package:flutter/cupertino.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('InPrize'),
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
