class MainBillsModel {
  int? currentPage;
  List<DataBillsModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MainBillsModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,

        this.path,
        this.perPage,
        this.to,
        this.total});

  MainBillsModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataBillsModel>[];
      json['data'].forEach((v) {
        data!.add(new DataBillsModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;

    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataBillsModel {
  int? id;
  String? billNo;
  String? totalAmount;
  String? userId;
  String? customerId;
  String? isPaid;
  String? payOption;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;

  DataBillsModel(
      {this.id,
        this.billNo,
        this.totalAmount,
        this.userId,
        this.customerId,
        this.isPaid,
        this.payOption,
        this.status,
        this.notes,
        this.createdAt,
        this.updatedAt});

  DataBillsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNo = json['bill_no'];
    totalAmount = json['total_amount'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    isPaid = json['is_paid'];
    payOption = json['pay_option'];
    status = json['status'];
    notes = json['notes'];
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
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

