class LocalProductModel {
  final int? id;
  final int productId;
  final String productName;
  String productImage;
  int productQuantity;
  final double productPrice;

  LocalProductModel(
      {
        this.id,
        required this.productId,
        required this.productName,
        required this.productQuantity,
        required this.productPrice,
        required this.productImage});

  factory LocalProductModel.fromJson(Map<String, dynamic> json) {
    return LocalProductModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      productQuantity: json['productQuantity'],
      productPrice:double.parse(json['productPrice']),
    );
  }
}


class RemoteProductModel {
  final int productId;
  final String productName;
  String productImage;
  int productQuantity;
  final double productPrice;

  RemoteProductModel(
      {
        required this.productId,
        required this.productName,
        required this.productQuantity,
        required this.productPrice,
        required this.productImage});

  factory RemoteProductModel.fromJson(Map<String, dynamic> json) {
    return RemoteProductModel(
      productId: json['id'],
      productName: json['name'],
      productImage: json['cover'],
      productQuantity: json['productQuantity']??0,
      productPrice:double.parse(json['price']),
    );
  }
}
