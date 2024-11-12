import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);
  Future<Product> searchProductByTerm(String term);
  Future<Product> createOrUpdateProduct(Map<String, dynamic> productLike);
}