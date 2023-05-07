import 'package:washing_line/data/model/product_model.dart';

class BillModel {
  final String delegateName;
  final String region;
  final String time;
  final String date;
  final String refNumber;
  final String deviceNumber;
  final String billNumber;
  final String taxNumber;
  final String branch;
  final String paymentMethod;
  final String clientName;
  final String clientNumber;
  final String clientCode;
  final List<ProductModel> products;
  final double price;
  final double tax;
  final double totalPrice;
  final String notice;

  BillModel(
      {
        required this.delegateName,
      required this.region,
      required this.time,
      required this.date,
      required this.refNumber,
      required this.deviceNumber,
      required this.billNumber,
      required this.taxNumber,
      required this.branch,
      required this.paymentMethod,
      required this.clientName,
      required this.clientNumber,
      required this.clientCode,
      required this.products,
      required this.price,
      required this.tax,
      required this.totalPrice,
      required this.notice
      });
}
