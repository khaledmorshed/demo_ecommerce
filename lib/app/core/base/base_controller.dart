import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:demo_ecommerce/app/network/exceptions/api_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/app_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/json_format_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/network_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/not_found_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/service_unavailable_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/timeout_exception.dart';
import 'package:demo_ecommerce/app/network/exceptions/unauthorized_exception.dart';
import 'package:demo_ecommerce/app/core/base/page_state.dart';

abstract class BaseController extends GetxController {
  final Logger logger = Logger();

  final _pageStateController = PageState.defaultState.obs;
  PageState get pageState => _pageStateController.value;
  updatePageState(PageState state) => _pageStateController(state);
  resetPageState() => _pageStateController(PageState.defaultState);

  showLoading() => updatePageState(PageState.loading);
  hideLoading() => resetPageState();

  final _errorMessageController = "".obs;
  String get errorMessage => _errorMessageController.value;
  showErrorMessage(String msg) => _errorMessageController(msg);

  final _successMessageController = "".obs;
  String get successMessage => _successMessageController.value;
  showSuccessMessage(String msg) => _successMessageController(msg);

  Future<dynamic> callDataService<T>(
    Future<T> future, {
    Function(Exception exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    bool isDefaultLoading = onStart == null;
    isDefaultLoading ? showLoading() : onStart();

    try {
      final T response = await future;
      if (onSuccess != null) onSuccess(response);
      return response;
    } on ServiceUnavailableException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on UnauthorizedException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on TimeoutException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on NetworkException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on JsonFormatException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on NotFoundException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on ApiException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } on AppException catch (error) {
      showErrorMessage(error.message);
      if (onError != null) onError(error);
    } catch (error) {
      showErrorMessage("Something went wrong");
      logger.e("Controller error: $error");
      if (onError != null) onError(Exception(error.toString()));
    } finally {
      if (isDefaultLoading) hideLoading();
      if (onComplete != null) onComplete();
    }
  }

  @override
  void onClose() {
    _pageStateController.close();
    _errorMessageController.close();
    _successMessageController.close();
    super.onClose();
  }
}
