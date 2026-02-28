import 'package:demo_ecommerce/app/core/base/base_view.dart';
import 'package:demo_ecommerce/app/core/widgets/product_card.dart';
import 'package:demo_ecommerce/app/core/widgets/sticky_tab_bar.dart';
import 'package:demo_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            _buildStickyTabs(),
            _buildTabPages(),
          ],
        ),
      );
    });
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: LayoutBuilder(
          builder: (context, constraints) {
            var top = constraints.biggest.height;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: top < 110 ? 1.0 : 0.0,
              child: const Text(
                'Daraz Shop',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          },
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://picsum.photos/seed/shop/800/400',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search in Daraz",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // sticky app bar
  Widget _buildStickyTabs() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        backgroundColor: Colors.white,
        tabBar: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          onTap: controller.onTabTapped,
          tabs: controller.categories
              .map((c) => Tab(text: c.toUpperCase()))
              .toList(),
        ),
      ),
    );
  }

  /// Horizontal swipe handled here (NOT vertical)
  Widget _buildTabPages() {
    return SliverFillRemaining(
      child: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: controller.categories.map((category) {
          return _buildProductGrid(category);
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid(String category) {
    return Obx(() {
      final products = controller.productsByCategory[category];
      final loading = controller.isLoadingCategory[category] ?? false;

      if (loading && (products == null || products.isEmpty)) {
        return const Center(child: CircularProgressIndicator());
      }

      if (products == null || products.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (_, i) => ProductCard(product: products[i]),
      );
    });
  }
}