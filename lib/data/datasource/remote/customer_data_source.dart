import 'package:dio/dio.dart';
import 'package:washing_line/app_api_links.dart';
import 'package:washing_line/core/class/curd_helper.dart';

import '../../../core/services/services.dart';

class CustomerDataSource{
  static searchCustomerByPhone(String phone)async{
    Response response=await Crud.dio.get(AppApiLinks.searchCustomerByPhone, queryParameters:{
      'phone':phone,
    } ,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
  static searchCustomerByCode(String phone)async{
    Response response=await Crud.dio.get(AppApiLinks.searchCustomerByPhone, queryParameters:{
      'code':phone,
    } ,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
  static searchCustomerBillsByCode(String code)async{
    Response response=await Crud.dio.get('${AppApiLinks.searchCustomerBillsByCode}phone=$code' ,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
  static addNewCustomer(Map<String,String> data)async{
    Response response=await Crud.dio.post(AppApiLinks.addNewCustomer,data: data,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
}