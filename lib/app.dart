import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/cubit/navigator_cubit.dart' as Nav;
import 'package:inprize/pages/home_page.dart';
import 'package:inprize/pages/loading_page.dart';
import 'package:inprize/pages/login_page.dart';

class InPrize extends StatelessWidget {
  const InPrize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Nav.NavigatorCubit>(
      create: (context) => Nav.NavigatorCubit(
        {
          '/': (BuildContext context) => const LoginPage(),
          '/loading': (BuildContext context) => const LoadingPage(),
          '/home': (BuildContext context) => const HomePage(),
        },
        '/',
      ),
      child: BlocBuilder<Nav.NavigatorCubit, Nav.NavigatorState>(
        builder: (BuildContext context, Nav.NavigatorState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  AuthCubit auth = AuthCubit(
                    navigator: context.read<Nav.NavigatorCubit>(),
                  );
                  auth.checkLoginStatus();
                  return auth;
                },
              ),
            ],
            child: CupertinoApp(
              debugShowCheckedModeBanner: false,
              title: 'InPrize',
              builder: (BuildContext context, Widget? child) {
                return DefaultTextStyle(
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                  child:
                      context.read<Nav.NavigatorCubit>().currentPage(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
