import 'package:demo_ecommerce/app/data/remote/product/product_remote_data_source.dart';
import 'package:demo_ecommerce/app/data/model/product.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Product>> getProductsByCategory(String category) {
    return _remoteDataSource.getProductsByCategory(category);
  }

  @override
  Future<List<String>> getCategories() {
    return _remoteDataSource.getCategories();
  }
}
