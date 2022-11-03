import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/choose_button.dart';
import 'package:inprize/widgets/media_details.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  void _showAlertDialog(BuildContext context, String content) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(content),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) {
        if (state is MediaError) {
          _showAlertDialog(context, state.errorMessage);
        }
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
