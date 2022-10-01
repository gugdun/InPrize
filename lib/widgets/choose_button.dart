import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/cubit/media_cubit.dart';

class ChooseButton extends StatelessWidget {
  const ChooseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext authContext, AuthState authState) {
        return BlocBuilder<MediaCubit, MediaState>(
          builder: (BuildContext mediaContext, MediaState mediaState) {
            return CupertinoButton.filled(
              onPressed: () {
                context
                    .read<MediaCubit>()
                    .chooseWinner(authState as AuthLoaded);
              },
              child: const Text(
                'Choose the winner',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
