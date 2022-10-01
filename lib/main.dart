import 'package:flutter/cupertino.dart';
import 'package:inprize/app.dart';
import 'package:inprize/services/ad_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdService.initialize();
  AdService.instance.showBanner();
  runApp(const InPrize());
}
