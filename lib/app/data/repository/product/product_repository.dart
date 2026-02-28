import 'package:demo_ecommerce/app/data/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}
