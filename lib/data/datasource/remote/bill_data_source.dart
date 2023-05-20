import 'package:dio/dio.dart';

import '../../../app_api_links.dart';
import '../../../core/class/curd_helper.dart';
import '../../../core/services/services.dart';

class BillDataSource {
  static addToBill(Map<String, dynamic> data) async {
    Response response = await Crud.dio.post(AppApiLinks.addToBill,
        options: Options(headers: {
          'Authorization':
              'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }),
        queryParameters: data
    );
    return response;
  }

  static getBill(String billId) async {
    Response response = await Crud.dio.get('${AppApiLinks.getBill}/$billId',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }));
    return response;
  }
  static searchBill(String billNo) async {
    Response response = await Crud.dio.get('${AppApiLinks.searchBill}?bill_no=$billNo',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }));
    return response;
  }
  static getBills(String status,String page) async {
    Response response =await Crud.dio.get('${AppApiLinks.getMainBills}$status&&page=$page',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }));
    return response;
  }
  static changeBillStatus(String billId) async {
    Response response = await Crud.dio.post('${AppApiLinks.changeBillStatus}/$billId',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }),data: {'status':'1'});
    return response;
  }
  static changeBillPaymentStatus(String billId,String paymentOption) async {
    Response response = await Crud.dio.post('${AppApiLinks.changeBillPaymentStatus}/$billId',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }),data: {'status':paymentOption});
    return response;
  }
  static changeBillPayment(String billId) async {
    Response response = await Crud.dio.post('${AppApiLinks.changeBillPayment}/$billId',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }));
    return response;
  }
}
