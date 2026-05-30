import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usedev_uninassau/src/models/product_model.dart';

class ProductService {
  final String _url = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar produtos');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}
