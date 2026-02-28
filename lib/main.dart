import "package:flutter/material.dart";
import 'app/my_app.dart';
import 'app/core/values/build_config.dart';
import 'app/core/values/env_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig devConfig = EnvConfig(
    appName: "Demo Ecommerce",
    baseUrl: "https://fakestoreapi.com/",
  );

  BuildConfig.instantiate(
    envType: Environment.development,
    envConfig: devConfig,
  );

  runApp(const MyApp());
}
