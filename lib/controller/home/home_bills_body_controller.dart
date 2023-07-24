import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:dio/dio.dart'as dio;
import 'package:washing_line/data/datasource/remote/bill_data_source.dart';
import 'package:washing_line/data/datasource/remote/customer_data_source.dart';
import 'package:washing_line/data/model/cleint_bills_model.dart';
import 'package:washing_line/data/model/main_Bills_model.dart';


abstract class HomeBodyController extends GetxController {
  void changeBillType(BillType type);
}

class HomeBillsBodyController extends HomeBodyController {
  ScrollController billsScrollController = ScrollController();

  HomeBillsBodyController(){
    selectedItem=='رقم الفاتورة';
    clientBills=ClientBillsModel(data: Data(bills: []));
    clientRequest=StatusRequest.initialState;
    update();
  }

 static HomeBillsBodyController get=Get.find<HomeBillsBodyController>();
 TextEditingController searchController=TextEditingController();
 List<String> items = ['رقم الفاتورة', 'رقم العميل','كود العميل'];
 String? selectedItem='رقم الفاتورة';
 BillType billType = BillType.didntDeliver;
 StatusRequest statusBills=StatusRequest.initialState;
 MainBillsModel? billsModel;
 ClientBillsModel? clientBills;
 StatusRequest clientRequest=StatusRequest.initialState;
  double clientBillsNum=0;
 double clientBillsPrice=0;
 List<dynamic> sortedBills =[];
 getClientBills()async{
   clientBillsNum=0;
   clientBillsPrice=0;
   try{
     clientRequest=StatusRequest.loading;
     update();
     dio.Response response;
     if(selectedItem=='رقم الفاتورة'){
       response=await BillDataSource.searchBill(searchController.text);
       print(response.data);
       clientBills=ClientBillsModel.fromJson({'success':true,'data':{'bills':response.data['data']}});

     }
     else if(selectedItem=='كود العميل'){
       response=await CustomerDataSource.searchCustomerBillsByCode(searchController.text);
       print(response.data);
       clientBills=ClientBillsModel.fromJson(response.data);

     }
     else{
       response=await CustomerDataSource.searchCustomerBillsByPhone(searchController.text);
       print(response.data);
       clientBills=ClientBillsModel.fromJson(response.data);

     }

     print(clientBills!.data!.bills);
     // if(response.data['data']['bills'].isNotEmpty){
       // print(clientBills!.data!.bills!.length);
       clientBills!.data!.bills!.forEach((element) {
         clientBillsNum++;
         clientBillsPrice+=double.parse(element.totalAmount!);
       });
       sortedBills = List.from(clientBills!.data!.bills!);
       sortedBills.sort((a, b) => a.status.compareTo(b.status) != 0
           ? a.status.compareTo(b.status)
           : a.id.compareTo(b.id));
       clientRequest=StatusRequest.success;

     // }else{
     //   Get.defaultDialog(title: 'تنبية',middleText: 'لا يوجد فواتير لهذا العميل');
     //   clientRequest=StatusRequest.serverFailure;
     // }

   }catch(error){
     print(error);
     clientRequest=StatusRequest.serverFailure;
     Get.defaultDialog(title: 'تنبية',middleText: 'لا يوجد فواتير لهذا الرقم');
   }
   print(clientRequest);
   update();
 }

  int currentPage = 1;
  int lastPage = 1;

  Future<void> getBills(String status) async {
    try {
      statusBills = StatusRequest.loading;
      update();

      dio.Response response = await BillDataSource.getBills(status,'1');
      print(response.data);
      billsModel = MainBillsModel.fromJson(response.data);
      print(billsModel!.data!.length);

      currentPage = billsModel?.currentPage ?? 1;
      lastPage = billsModel?.lastPage ?? 1;
      billsScrollController.addListener(() {
        if (billsScrollController.position.pixels ==
            billsScrollController.position.maxScrollExtent) {
          // User has reached the end of the list, load the next page here

          loadNextPage(status);
        }
      });
      statusBills = StatusRequest.success;
    } catch (error) {
      print(error);
      statusBills = StatusRequest.serverFailure;
    }
    update();
  }

  Future<void> loadNextPage(String status) async {
    if (currentPage < lastPage) {
      try {
        dio.Response response = await BillDataSource.getBills(status, '${currentPage + 1}');
        MainBillsModel nextPageModel = MainBillsModel.fromJson(response.data);
        billsModel?.data?.addAll(nextPageModel.data ?? []);
        currentPage = nextPageModel.currentPage ?? currentPage + 1;
      } catch (error) {
        print(error);
        statusBills = StatusRequest.serverFailure;
      }
    }
    update();
  }

  DataBillsModel? getLastItem() {
    if (billsModel?.data != null && billsModel!.data!.isNotEmpty) {
      return billsModel!.data!.last;
    }
    return null;
  }  @override
  void changeBillType(BillType type) {
    billType = type;
    if(type==BillType.didntDeliver){
      getBills('0');
    }
    else if(type==BillType.waiting){
      getBills('1');
    }
    else{
      getBills('2');
    }
  }
 StatusRequest billRequest=StatusRequest.initialState;
}

enum BillType { delivered, didntDeliver, waiting }
