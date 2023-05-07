class ProductModel {
  final int? id;
  final int productId;
  final String productName;
  String productImage;
  int productQuantity;
  final double productPrice;

  ProductModel(
      {
         this.id,
        required this.productId,
        required this.productName,
      required this.productQuantity,
      required this.productPrice,
      required this.productImage});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      productQuantity: json['productQuantity'],
      productPrice:double.parse(json['productPrice']),
    );
  }
}
