import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  NavigatorCubit(
      Map<String, Widget Function(BuildContext)> routes, String defaultRoute)
      : super(NavigatorState(
            routes: routes, navigatorStack: <String>[defaultRoute]));

  Widget currentPage(BuildContext context) =>
      state.routes[state.navigatorStack.last]!(context);

  void replace(String route) {
    emit(NavigatorState(
      routes: state.routes,
      navigatorStack: <String>[route],
    ));
  }

  void push(String route) {
    List<String> stack = state.navigatorStack.sublist(0);
    stack.add(route);
    emit(NavigatorState(routes: state.routes, navigatorStack: stack));
  }

  void pop() {
    emit(NavigatorState(
      routes: state.routes,
      navigatorStack: state.navigatorStack.sublist(
        0,
        state.navigatorStack.length - 1,
      ),
    ));
  }
}
