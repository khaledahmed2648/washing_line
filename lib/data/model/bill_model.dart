import 'package:washing_line/data/model/product_model.dart';

import 'customer_model.dart';
class BillModel {
  bool? success;
  Data? data;
  Null? message;

  BillModel({this.success, this.data, this.message});

  BillModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? billNo;
  String? totalAmount;
  String? userId;
  String? customerId;
  String? isPaid;
  String? payOption;
  String? status;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  Customer? customer;
  Delivery? delivery;
  List<Products>? products;

  Data(
      {this.id,
        this.billNo,
        this.totalAmount,
        this.userId,
        this.customerId,
        this.isPaid,
        this.payOption,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.customer,
        this.delivery,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNo = json['bill_no'];
    totalAmount = json['total_amount'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    isPaid = json['is_paid'];
    payOption = json['pay_option'];
    status = json['status'];
    delivery=Delivery.fromJson(json['delivery']);
    notes = json['notes'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_no'] = this.billNo;
    data['total_amount'] = this.totalAmount;
    data['user_id'] = this.userId;
    data['customer_id'] = this.customerId;
    data['is_paid'] = this.isPaid;
    data['pay_option'] = this.payOption;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['delivery'] = this.delivery;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? location;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.name,
        this.phone,
        this.code,
        this.location,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? cover;
  String? categoryId;
  String? subCategoryId;
  String? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Products(
      {this.id,
        this.name,
        this.cover,
        this.categoryId,
        this.subCategoryId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    quantity=json['pivot']['quantity']==null?1:int.parse(json['pivot']['quantity']);
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? billId;
  String? productId;

  Pivot({this.billId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_id'] = this.billId;
    data['product_id'] = this.productId;
    return data;
  }
}
class Delivery {
  String id;
  String name;
  String username;
  String phone;
  String profilePicture;
  String branch;
  String area;
  String billsStartsAt;
  DateTime createdAt;
  DateTime updatedAt;

  Delivery({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.profilePicture,
    required this.branch,
    required this.area,
    required this.billsStartsAt,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'].toString(),
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      profilePicture: json['profile_picture'],
      branch: json['branch'],
      area: json['area'],
      billsStartsAt: json['bills_starts_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}