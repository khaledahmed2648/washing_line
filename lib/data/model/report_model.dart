class DurationReports {
  int id;
  String billNo;
  String totalAmount;
  int userId;
  int customerId;
  bool isPaid;
  int payOption;
  int status;
  String? notes;
  DateTime createdAt;
  DateTime updatedAt;

  DurationReports({
    required this.id,
    required this.billNo,
    required this.totalAmount,
    required this.userId,
    required this.customerId,
    required this.isPaid,
    required this.payOption,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DurationReports.fromJson(Map<String, dynamic> json) {
    return DurationReports(
      id: json['id'],
      billNo: json['bill_no'],
      totalAmount: json['total_amount'],
      userId: int.parse(json['user_id']),
      customerId: int.parse(json['customer_id']),
      isPaid: json['is_paid'] == "1",
      payOption: int.parse(json['pay_option']),
      status: int.parse(json['status']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
