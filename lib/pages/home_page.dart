import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/widgets/media_feed.dart';
import 'package:inprize/widgets/user_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _userInfoPanel(AuthLoaded state) {
    return state.userData != null
        ? UserWidget(userData: state.userData!)
        : const Text('No Instagram account associated with this account.');
  }

  Widget _userName(AuthLoaded state) {
    return state.userData != null
        ? Text('@${state.userData!.username}')
        : const Text('InPrize');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, __) => false,
      builder: (BuildContext context, AuthState state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            automaticallyImplyMiddle: false,
            padding: const EdgeInsetsDirectional.all(0),
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => context.read<AuthCubit>().logOut(),
            ),
            middle: _userName(state as AuthLoaded),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _userInfoPanel(state),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: MediaFeed()),
              ],
            ),
          ),
        );
      },
    );
  }
}
