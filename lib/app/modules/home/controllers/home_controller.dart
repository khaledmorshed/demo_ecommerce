import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_ecommerce/app/core/base/base_controller.dart';
import 'package:demo_ecommerce/app/data/model/product.dart';
import 'package:demo_ecommerce/app/data/repository/product/product_repository.dart';

class HomeController extends BaseController
    with GetTickerProviderStateMixin {
  final ProductRepository _productRepository;

  HomeController(this._productRepository);

  final RxList<String> categories = <String>[].obs;
  final RxMap<String, List<Product>> productsByCategory = <String, List<Product>>{}.obs;
  final RxMap<String, bool> isLoadingCategory = <String, bool>{}.obs;
  final RxBool isLoading = false.obs;

  late TabController tabController;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    callDataService(
      _productRepository.getCategories(),
      onSuccess: (fetchedCategories) {
        categories.assignAll(fetchedCategories);

        tabController.dispose();
        tabController = TabController(
          length: categories.length,
          vsync: this,
        );

        if (categories.isNotEmpty) {
          fetchProductsByCategory(categories.first);
        }
      },
      onComplete: () => isLoading.value = false,
    );
  }

  Future<void> fetchProductsByCategory(String category) async {
    if (productsByCategory[category]?.isNotEmpty == true) return;

    callDataService(
      _productRepository.getProductsByCategory(category),
      onStart: () => isLoadingCategory[category] = true,
      onComplete: () => isLoadingCategory[category] = false,
      onSuccess: (products) {
        productsByCategory[category] = products;
      },
    );
  }

  void onTabTapped(int index) {
    fetchProductsByCategory(categories[index]);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int index) {
    tabController.animateTo(index);
    fetchProductsByCategory(categories[index]);
  }

  Future<void> refreshData() async {
    productsByCategory.clear();
    isLoadingCategory.clear();
    await fetchCategories();
  }

  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
    super.onClose();
  }
}