part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const SETTINGS = _Paths.SETTINGS;
  static const LOGIN = _Paths.LOGIN;
}

abstract class _Paths {
  _Paths._();
  static const MAIN = '/main';
  static const HOME = '/home';
  static const SETTINGS = '/settings';
  static const LOGIN = '/login';
}