import 'package:get/get.dart';

class DelegateReportsController extends GetxController{
  ReportsTurn reportsTurn=ReportsTurn.daily;
void changeReportsTurn(ReportsTurn turn){
  reportsTurn=turn;
  update();
}
}

enum ReportsTurn{
  daily,
  monthly,
  yearly,
}