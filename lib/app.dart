import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/cubit/navigator_cubit.dart' as nav;
import 'package:inprize/pages/home_page.dart';
import 'package:inprize/pages/loading_page.dart';
import 'package:inprize/pages/login_page.dart';
import 'package:inprize/pages/media_page.dart';
import 'package:inprize/pages/result_page.dart';

class InPrize extends StatelessWidget {
  const InPrize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<nav.NavigatorCubit>(
      create: (context) => nav.NavigatorCubit(
        {
          '/': (BuildContext context) => const LoginPage(),
          '/loading': (BuildContext context) => const LoadingPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/media': (BuildContext context) => const MediaPage(),
          '/result': (BuildContext context) => const ResultPage(),
        },
        '/',
      ),
      child: BlocBuilder<nav.NavigatorCubit, nav.NavigatorState>(
        builder: (BuildContext context, nav.NavigatorState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                create: (BuildContext context) {
                  AuthCubit auth = AuthCubit(
                    navigator: context.read<nav.NavigatorCubit>(),
                  );
                  auth.checkLoginStatus();
                  return auth;
                },
              ),
              BlocProvider<MediaCubit>(
                create: (BuildContext context) => MediaCubit(
                  navigator: context.read<nav.NavigatorCubit>(),
                ),
              ),
            ],
            child: CupertinoApp(
              debugShowCheckedModeBanner: false,
              title: 'InPrize',
              home: WillPopScope(
                onWillPop: () async => context.read<nav.NavigatorCubit>().pop(),
                child: context.read<nav.NavigatorCubit>().currentPage(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
