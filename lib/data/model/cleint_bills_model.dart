class ClientBillsModel {
  bool? success;
  Data? data;
  Null? message;

  ClientBillsModel({this.success, this.data, this.message});

  ClientBillsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<Bills>? bills;

  Data({this.bills});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bills'] != null) {
      bills = <Bills>[];
      json['bills'].forEach((v) {
        bills!.add(Bills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.bills != null) {
      data['bills'] = this.bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bills {
  int? id;
  String? billNo;
  String? totalAmount;
  String? userId;
  String? customerId;
  String? isPaid;
  String? payOption;
  String? status;
  String? createdAt;
  String? updatedAt;

  Bills({
    this.id,
    this.billNo,
    this.totalAmount,
    this.userId,
    this.customerId,
    this.isPaid,
    this.payOption,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Bills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNo = json['bill_no'];
    totalAmount = json['total_amount'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    isPaid = json['is_paid'];
    payOption = json['pay_option'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}

