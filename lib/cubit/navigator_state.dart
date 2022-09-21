part of 'navigator_cubit.dart';

class NavigatorState {
  final Map<String, Widget Function(BuildContext)> routes;
  final List<String> navigatorStack;

  NavigatorState({required this.routes, required this.navigatorStack});
}
