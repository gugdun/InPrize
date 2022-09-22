import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  SharedPreferences? preferences;

  AccessToken? getAccessToken() {
    String? string = preferences!.getString('access_token');
    if (string != null) {
      Map<String, dynamic> json = jsonDecode(string);
      return AccessToken(
        userId: json['userId'],
        token: json['token'],
        expires: DateTime.parse(json['expires']),
        lastRefresh: DateTime.parse(json['lastRefresh']),
        applicationId: json['applicationId'],
        graphDomain: json['graphDomain'],
        isExpired: json['isExpired'],
        declinedPermissions: json['declinedPermissions'] != null
            ? List<String>.from(json['declinedPermissions'])
            : null,
        grantedPermissions: json['grantedPermissions'] != null
            ? List<String>.from(json['grantedPermissions'])
            : null,
      );
    } else {
      return null;
    }
  }

  UserData? getUserData() {
    String? string = preferences!.getString('user_data');
    if (string != null) {
      return UserData.fromJson(jsonDecode(string));
    } else {
      return null;
    }
  }

  List<IgMedia>? getUserFeed() {
    String? string = preferences!.getString('user_feed');
    if (string != null) {
      return jsonDecode(string)
          .map<IgMedia>((e) => IgMedia.fromJson(e))
          .toList();
    } else {
      return null;
    }
  }

  Future<void> setAccessToken(AccessToken? token) async {
    if (token == null) {
      await preferences!.remove('access_token');
    } else {
      await preferences!.setString(
        'access_token',
        jsonEncode(token.toJson()),
      );
    }
  }

  Future<void> setUserData(UserData? data) async {
    if (data == null) {
      await preferences!.remove('user_data');
    } else {
      await preferences!.setString(
        'user_data',
        jsonEncode(data.toJson()),
      );
    }
  }

  Future<void> setUserFeed(List<IgMedia>? feed) async {
    if (feed == null) {
      await preferences!.remove('user_feed');
    } else {
      await preferences!.setString(
        'user_feed',
        jsonEncode(feed.map<Map<String, dynamic>>((e) => e.toJson()).toList()),
      );
    }
  }

  static AppCache? _instance;

  static AppCache get instance => _instance!;

  static Future<void> load() async {
    if (_instance != null) {
      _instance!.preferences = await SharedPreferences.getInstance();
    } else {
      _instance = AppCache();
      _instance!.preferences = await SharedPreferences.getInstance();
    }
  }
}
