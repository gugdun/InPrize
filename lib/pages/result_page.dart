import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/media_cubit.dart';
import 'package:inprize/widgets/comment_widget.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (BuildContext context, MediaState state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            automaticallyImplyMiddle: false,
            padding: const EdgeInsetsDirectional.all(0),
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => context.read<MediaCubit>().closeMedia(),
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
                  onPressed: () {},
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
