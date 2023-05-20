import 'package:flutter/material.dart';
import 'package:magento_app/services/local_notification_service.dart';
//import 'package:flutter_config/flutter_config.dart';

import 'common/common_export.dart';
import 'presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await FlutterConfig.loadEnvVariables();
  configLocator();
  await SharePreferencesConstants().init();
  LocalNotificationService.initNotificationLocal();

  runApp(const App());
}
