import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/widgets/media_feed.dart';
import 'package:inprize/widgets/user_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _userInfoPanel(BuildContext context, AuthLoaded state) {
    return state.userData != null
        ? UserWidget(userData: state.userData!)
        : Text(
            'No Instagram account associated with this account.',
            style: TextStyle(
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          );
  }

  Widget _userName(BuildContext context, AuthLoaded state) {
    return state.userData != null
        ? Text(
            '@${state.userData!.username}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          )
        : Text(
            'InPrize',
            style: TextStyle(
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, __) => false,
      builder: (BuildContext context, AuthState state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.all(0),
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => context.read<AuthCubit>().logOut(),
            ),
            middle: _userName(context, state as AuthLoaded),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _userInfoPanel(context, state),
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
