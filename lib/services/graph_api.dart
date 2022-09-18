import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/models/user_data.dart';

const String authority = 'graph.facebook.com';
const String version = 'v15.0';

class GraphApi {
  final String token;

  GraphApi({required this.token});

  Future<UserData?> getInstagramAccount() async {
    // Send API request
    Response response = await http.get(Uri.https(
      authority,
      '/$version/me/accounts',
      <String, dynamic>{
        'fields':
            'connected_instagram_account{id,name,username,biography,profile_picture_url}',
        'access_token': token,
      },
    ));
    // Parse API response
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data']?[0]?['connected_instagram_account'] != null) {
      return UserData.fromJson(json['data'][0]['connected_instagram_account']);
    } else {
      return null;
    }
  }

  Future<List<IgMedia>> getUserMedia(String? id) async {
    // Send API request
    Response response = await http.get(Uri.https(
      authority,
      '/$version/$id/media',
      <String, dynamic>{
        'fields':
            'id,caption,like_count,is_comment_enabled,comments_count,is_shared_to_feed,media_type,media_url,thumbnail_url',
        'access_token': token,
      },
    ));
    // Parse API response
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] is List) {
      return (json['data'] as List)
          .map<IgMedia>((media) => IgMedia.fromJson(media))
          .toList();
    } else {
      return <IgMedia>[];
    }
  }

  static GraphApi? _instance;

  static GraphApi get instance => _instance!;

  static void initialize(String token) {
    if (token != _instance?.token) {
      _instance = GraphApi(token: token);
    }
  }
}
