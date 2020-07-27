// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

//List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

//String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Product> productFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Product>.from(data.map((item) => Product.fromJson(item)));
}
String productToJson(Product data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class Product {

  Product({
    this.id,
    this.productName,
    this.productDetail,
    this.productBarcode,
    this.productQty,
    this.productPrice,
    this.productImage,
    this.productCategory,
    this.productStatus,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String productName;
  String productDetail;
  String productBarcode;
  int productQty;
  String productPrice;
  String productImage;
  String productCategory;
  int productStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    productDetail: json["product_detail"],
    productBarcode: json["product_barcode"],
    productQty: json["product_qty"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    productCategory: json["product_category"],
    productStatus: json["product_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_detail": productDetail,
    "product_barcode": productBarcode,
    "product_qty": productQty,
    "product_price": productPrice,
    "product_image": productImage,
    "product_category": productCategory,
    "product_status": productStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, productDetail: $productDetail, productBarcode: $productBarcode, productQty: $productQty, productPrice: $productPrice, productImage: $productImage, productCategory: $productCategory, productStatus: $productStatus, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
