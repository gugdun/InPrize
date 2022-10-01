import 'package:flutter/cupertino.dart';
import 'package:inprize/models/user_data.dart';

class UserWidget extends StatelessWidget {
  final UserData userData;

  const UserWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            userData.profilePictureUrl,
            fit: BoxFit.cover,
            cacheWidth: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userData.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              Text(
                userData.biography,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
