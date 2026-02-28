import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:demo_ecommerce/app/core/base/base_controller.dart';
import 'package:demo_ecommerce/app/core/base/page_state.dart';
import 'package:demo_ecommerce/app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:demo_ecommerce/app/core/widgets/custom_snackbar.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
abstract class BaseView<Controller extends BaseController> extends GetView<Controller> {
  BaseView({super.key});

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final Logger logger = Logger();

  late final ThemeData _theme;

  ThemeData get theme => _theme;

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _theme = context.theme;
    return GestureDetector(
      onTap: () {
        if (activeGestureDetector) {
          closeKeyboard();
        }
      },
      child: Stack(
        children: [
          annotatedRegion(context),
          Obx(() => controller.pageState == PageState.loading
              ? _showLoading()
              : const SizedBox.shrink()),
          Obx(() => controller.errorMessage.isNotEmpty
              ? showErrorSnackBar(controller.errorMessage)
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle ??
          theme.appBarTheme.systemOverlayStyle ??
          SystemUiOverlayStyle(
            statusBarColor: statusBarColor(),
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
      child: Material(
        color: Colors.transparent,
        child: pageScaffold(context),
      ),
    );
  }

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: pageBackGroundColor(),
      appBar: appBar(context),
      body: pageContent(context),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: drawer(),
      bottomSheet: _bottomSheet(),
      floatingActionButton: floatingActionButton(),
    );
  }

  Color statusBarColor() {
    return theme.scaffoldBackgroundColor;
  }

  Color pageBackGroundColor() {
    return theme.scaffoldBackgroundColor;
  }

  Widget pageContent(BuildContext context) {
    return SafeArea(
      child: body(context),
    );
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget? _bottomSheet() {
    final sheet = bottomSheet();
    if (sheet == null) return null;
    return Wrap(
      children: [
        sheet,
      ],
    );
  }

  Widget? bottomSheet() {
    return null;
  }

  Widget showErrorSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      customSnackBar(message);
      // Reset error after showing
      controller.showErrorMessage("");
    });
    return const SizedBox.shrink();
  }

  Widget _showLoading() {
    return const CustomCircularProgressIndicator();
  }

  SystemUiOverlayStyle? get systemUiOverlayStyle {
    return null;
  }

  bool get activeGestureDetector => true;

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}