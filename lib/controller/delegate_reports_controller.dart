import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:intl/intl.dart';
import 'package:washing_line/data/datasource/remote/reports_data_source.dart';
import 'package:washing_line/data/model/report_model.dart';
import '../core/class/curd_helper.dart';
import '../data/datasource/remote/bill_data_source.dart';
import '../data/model/main_Bills_model.dart';

class DelegateReportsController extends GetxController{
  DelegateReportsController(){
    getReports('0');
  }
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat monthFormatter = DateFormat('yyyy-MM');
  ReportsTurn reportsTurn=ReportsTurn.daily;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),

    );
    if (picked != null && picked != selectedDate) {

        selectedDate = picked;
        getReports(reportsTurn==ReportsTurn.daily?'0':'1');
        print(formatter.format(selectedDate));
      update();
    }
  }

  void changeReportsTurn(ReportsTurn turn){
  reportsTurn=turn;
  if(turn==ReportsTurn.daily){
    getReports('0');
  }
  else if(turn==ReportsTurn.monthly) {
    getReports('1');
  }


  update();
}
  StatusRequest statusBills=StatusRequest.initialState;
  List<DurationReports> billsModel=[];
  int clientBillsNum=0;
  double clientBillsPrice=0;
  getReports(String status)async{
    clientBillsNum=0;
     clientBillsPrice=0;
    billsModel=[];
    try{
      statusBills=StatusRequest.loading;
      update();
      if(status!='0'){
          dio.Response response=  await  ReportsDataSource.getMonthlyReports(monthFormatter.format(selectedDate));
          print(response.data);
          if(response.data.isNotEmpty){
            List<dynamic> jsonData = response.data['data'];
            List<DurationReports> durationReportsList = jsonData.map((e) => DurationReports.fromJson(e)).toList();
            billsModel = durationReportsList;
            durationReportsList.forEach((element) {
              clientBillsNum++;
              clientBillsPrice += double.parse(element.totalAmount);
            });
          }


      }
      else{
        dio.Response response = await ReportsDataSource.getDailyReports(formatter.format(selectedDate));
        print(response.data);
        if(response.data.isNotEmpty){
          List<dynamic> jsonData = response.data['data'];
          List<DurationReports> durationReportsList = jsonData.map((e) => DurationReports.fromJson(e)).toList();
          billsModel = durationReportsList;
          billsModel.forEach((element) {
            clientBillsNum++;
            clientBillsPrice += double.parse(element.totalAmount);
          });

        }
      }

      statusBills=StatusRequest.success;
    }catch(error){
      print(error);
      statusBills=StatusRequest.serverFailure;
    }
    update();
  }
}

enum ReportsTurn{
  daily,
  monthly,
  yearly,
}