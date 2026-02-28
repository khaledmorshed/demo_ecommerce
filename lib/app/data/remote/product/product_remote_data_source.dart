import 'package:demo_ecommerce/app/data/model/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}
