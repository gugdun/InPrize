import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:inprize/models/user_data.dart';

class UserWidget extends StatelessWidget {
  final UserData userData;

  const UserWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: userData.profilePictureUrl,
            placeholder: (BuildContext context, String url) =>
                const CupertinoActivityIndicator(),
            errorWidget: (BuildContext context, String url, _) => const Icon(
              CupertinoIcons.exclamationmark_circle,
              color: Color.fromRGBO(255, 0, 0, 1),
            ),
            fit: BoxFit.cover,
            memCacheWidth: 200,
            maxWidthDiskCache: 200,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userData.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 4)),
                Text(
                  userData.biography,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
