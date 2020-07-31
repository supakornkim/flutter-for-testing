import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stock/utils/constants.dart';
import 'package:flutter_stock/models/Product.dart';


class CallAPI {

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  // Login
  postData(data, apiURL) async {

    var fullURL = baseUrlAPI + apiURL;
    return await http.post(
        fullURL,
        body: jsonEncode(data),
        headers: _setHeaders()
    );

  }

  // ส่วนของการ CRUD Product
  // Get All Products
  Future<List<Product>> getProducts() async {
    final response = await http.get(baseUrlAPI + "products", headers: _setHeaders());
    if(response.statusCode == 200){
      return productFromJson(response.body);
    }else{
      return null;
    }
  }

  // Create Products
  Future<bool> createProduct(Product data) async {
    final response = await http.post(
        baseUrlAPI + "products",
        headers: _setHeaders(),
        body: productToJson(data)
    );
    //print(productToJson(data));
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }

  }

  // Update Products
  Future<bool> updateProduct(Product data) async {
    final response = await http.put(
      baseUrlAPI+"products/${data.id}",
      headers: _setHeaders(),
      body: productToJson(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete Products
  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(
        baseUrlAPI+"products/$id",
        headers: _setHeaders()
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}