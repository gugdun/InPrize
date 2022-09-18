import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inprize/models/user_data.dart';
import 'package:inprize/pages/home_page.dart';
import 'package:inprize/pages/loading_page.dart';
import 'package:inprize/pages/login_page.dart';
import 'package:inprize/services/app_cache.dart';
import 'package:inprize/services/graph_api.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> checkLoginStatus() async {
    emit(AuthLoading());
    await AppCache.load();
    final AccessToken? token = AppCache.instance.getAccessToken();
    final UserData? data = AppCache.instance.getUserData();
    if (token != null && token.isExpired == false) {
      GraphApi.initialize(token.token);
      emit(AuthLoaded(accessToken: token, userData: data));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> loginWithFacebook() async {
    emit(AuthLoading());

    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'user_posts',
        'openid',
        'email',
        'pages_show_list',
        'instagram_basic',
        'page_events',
        'pages_read_engagement',
        'pages_manage_metadata',
        'pages_read_user_content',
        'pages_manage_posts',
        'pages_manage_engagement',
        'public_profile',
      ],
    );

    if (result.status == LoginStatus.success) {
      final AccessToken? token = result.accessToken;
      GraphApi.initialize(result.accessToken!.token);
      final UserData? data = await GraphApi.instance.getInstagramAccount();
      await AppCache.load();
      await Future.wait(<Future>[
        AppCache.instance.setAccessToken(token),
        AppCache.instance.setUserData(data),
      ]);
      emit(AuthLoaded(accessToken: token, userData: data));
    } else {
      emit(AuthError(loginResult: result));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    await Future.wait(<Future>[
      AppCache.instance.setAccessToken(null),
      AppCache.instance.setUserData(null),
      FacebookAuth.instance.logOut(),
    ]);
    emit(AuthInitial());
  }

  Widget get home {
    if (state is AuthInitial) {
      return const LoginPage();
    } else if (state is AuthLoading) {
      return const LoadingPage();
    } else if (state is AuthLoaded) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
