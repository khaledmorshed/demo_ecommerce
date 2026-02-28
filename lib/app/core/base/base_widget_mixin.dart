import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

mixin BaseWidgetMixin on StatelessWidget {
  final Logger logger = Logger();

  late ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  Widget build(BuildContext context) {
    _theme = context.theme;

    return body(context);
  }

  Widget body(BuildContext context);
}
