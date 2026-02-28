import 'env_config.dart';

enum Environment { development, production }

class BuildConfig {
  late final EnvConfig envConfig;
  late final Environment environment;

  static final BuildConfig _instance = BuildConfig._internal();

  static BuildConfig get instance => _instance;

  BuildConfig._internal();

  static void instantiate({
    required Environment envType,
    required EnvConfig envConfig,
  }) {
    _instance.environment = envType;
    _instance.envConfig = envConfig;
  }
}
