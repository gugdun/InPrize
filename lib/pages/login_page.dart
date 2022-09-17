import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/widgets/facebook_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, __) => false,
      builder: (BuildContext context, AuthState state) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('InPrize'),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: FacebookButton(
                      onPressed: () =>
                          context.read<AuthCubit>().loginWithFacebook(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text('Log In'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
