import 'package:flutter/widgets.dart';
import 'package:jewelme_application/app/app.dart';
import 'package:jewelme_application/app/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies and HiveService together
  await initDependencies();

  runApp(MyApp());
}
