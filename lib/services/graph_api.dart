import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inprize/models/comment.dart';
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/models/user_data.dart';
import 'package:inprize/services/app_cache.dart';

const String authority = 'graph.facebook.com';
const String version = 'v15.0';

class GraphApi {
  final String _token;
  final _userMedia = StreamController<List<IgMedia>>.broadcast();

  GraphApi({required String token}) : _token = token;

  Future<UserData?> getInstagramAccount() async {
    // Send API request
    Response response = await http.get(Uri.https(
      authority,
      '/$version/me/accounts',
      <String, dynamic>{
        'fields': 'connected_instagram_account{id,name,username,biography,profile_picture_url}',
        'access_token': _token,
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

  Future<List<Comment>> getMediaComments(String? id) async {
    // Send API request
    Response response = await http.get(Uri.https(
      authority,
      '/$version/$id/comments',
      <String, dynamic>{
        'fields': 'id,timestamp,username,text,like_count,replies{id,timestamp,username,text,like_count}',
        'access_token': _token,
      },
    ));
    // Parse API response
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] is List) {
      List<Comment> comments = <Comment>[];
      for (Map<String, dynamic> comment in json['data']) {
        comments.add(Comment.fromJson(comment));
        if (comment['replies'] != null) {
          for (Map<String, dynamic> comment in comment['replies']['data']) {
            comments.add(Comment.fromJson(comment));
          }
        }
      }
      return comments;
    } else {
      return <Comment>[];
    }
  }

  Stream<List<IgMedia>> getUserMedia(String? id) {
    // Check cache
    List<IgMedia>? feed = AppCache.instance.getUserFeed();
    if (feed != null) {
      Future.delayed(const Duration(), () => _userMedia.add(feed!));
      return _userMedia.stream;
    }
    // Send API request
    http
        .get(Uri.https(
      authority,
      '/$version/$id/media',
      <String, dynamic>{
        'fields': 'id,caption,like_count,is_comment_enabled,comments_count,is_shared_to_feed,media_type,media_url,thumbnail_url',
        'access_token': _token,
      },
    ))
        // Parse API response
        .then((Response response) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['data'] is List) {
        feed = (json['data'] as List)
            .map<IgMedia>((media) => IgMedia.fromJson(media))
            .toList();
        AppCache.instance.setUserFeed(feed);
        _userMedia.add(feed!);
      } else {
        _userMedia.add(<IgMedia>[]);
      }
    });
    return _userMedia.stream;
  }

  static GraphApi? _instance;

  static GraphApi get instance => _instance!;

  static void initialize(String token) {
    if (token != _instance?._token) {
      _instance = GraphApi(token: token);
    }
  }
}
