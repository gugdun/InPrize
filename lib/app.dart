import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';

class InPrize extends StatelessWidget {
  const InPrize({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'InPrize',
            builder: (context, child) {
              return DefaultTextStyle(
                style: CupertinoTheme.of(context).textTheme.textStyle,
                child: context.read<AuthCubit>().home,
              );
            },
          );
        },
      ),
    );
  }
}
