import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inprize/models/user_data.dart';
import 'package:inprize/pages/home_page.dart';
import 'package:inprize/pages/loading_page.dart';
import 'package:inprize/pages/login_page.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
      final Map<String, dynamic> accounts = await _getAccounts(
        result.accessToken!.token,
      );
      final AccessToken? token = result.accessToken;
      UserData? data;
      if (accounts['data'][0]['connected_instagram_account'] != null) {
        data = UserData.fromJson(
          accounts['data'][0]['connected_instagram_account'],
        );
      }
      emit(AuthLoaded(accessToken: token, userData: data));
    } else {
      emit(AuthError(loginResult: result));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    await FacebookAuth.instance.logOut();
    emit(AuthInitial());
  }

  Future<Map<String, dynamic>> _getAccounts(String token) async {
    Response response = await http.get(
      Uri.parse(
        'https://graph.facebook.com/v15.0/me/accounts?fields=connected_instagram_account{id,name,username,biography,profile_picture_url}&access_token=$token',
      ),
    );
    return jsonDecode(response.body);
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
