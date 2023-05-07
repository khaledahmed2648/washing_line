import 'bill_model.dart';

class DateBillsModel{
  final String billDate;
  final String delegateName;
  final String delegateCode;
  final List<BillModel> bills;

  DateBillsModel(this.billDate,this.delegateName, this.delegateCode, this.bills);
}