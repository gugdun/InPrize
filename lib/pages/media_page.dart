import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/choose_button.dart';
import 'package:inprize/widgets/media_details.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.all(0),
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => context.read<MediaCubit>().closeMedia(),
            ),
            middle: const Text('Publication'),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: MediaDetails(),
                ),
                (state as MediaSelected).currentMedia.commentsCount > 0
                    ? const ChooseButton()
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
