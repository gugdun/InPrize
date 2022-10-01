import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/comment_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  Future<void> _openProfile(String username) async {
    Uri app = Uri.parse('https://www.instagram.com/_u/$username/');
    Uri browser = Uri.parse('https://www.instagram.com/$username/');
    if (await canLaunchUrl(app)) {
      await launchUrl(app, mode: LaunchMode.externalNonBrowserApplication);
    } else if (await canLaunchUrl(browser)) {
      await launchUrl(browser, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.all(0),
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => context.read<MediaCubit>().closeResults(),
            ),
            middle: const Text('Results'),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Winner!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 32),
                  child: CommentWidget(),
                ),
                CupertinoButton.filled(
                  onPressed: () => _openProfile(
                    (state as MediaLoaded).comment.username,
                  ),
                  child: const Text(
                    'Open profile',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
