import 'package:demo_ecommerce/app/core/base/base_remote_source.dart';
import 'package:demo_ecommerce/app/data/model/product.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl extends BaseRemoteSource implements ProductRemoteDataSource {
  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    var endpoint = "https://fakestoreapi.com/products/category/$category";
    var dioCall = dioClient.get(endpoint);

    try {
      final response = await callApiWithErrorParser(dioCall);
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getCategories() async {
    var endpoint = "https://fakestoreapi.com/products/categories";
    var dioCall = dioClient.get(endpoint);

    try {
      final response = await callApiWithErrorParser(dioCall);
      return (response.data as List).map((e) => e.toString()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
