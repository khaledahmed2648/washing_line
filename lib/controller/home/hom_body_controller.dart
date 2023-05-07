import 'package:get/get.dart';
import 'package:washing_line/core/constant/assets_route.dart';

import '../../../data/model/service_model.dart';
abstract class HomeBodyController extends GetxController{
  void changeBillType(BillType type);
}
class HomeBodyControllerImp extends HomeBodyController{
List<ServiceModel> services=[
  ServiceModel(serviceName: 'غسيل', serviceImageUrl: '${AppAssetUrl.rootServices}/service_washing.png'),
  ServiceModel(serviceName: 'طى', serviceImageUrl: '${AppAssetUrl.rootServices}/service_folding.png'),
  ServiceModel(serviceName: 'كوى', serviceImageUrl: '${AppAssetUrl.rootServices}/service_iron.png'),
  ServiceModel(serviceName: 'تجفيف', serviceImageUrl: '${AppAssetUrl.rootServices}/service_drying.png'),
  ServiceModel(serviceName: 'غسيل و كوى', serviceImageUrl: '${AppAssetUrl.rootServices}/service_iron_and_washing.png'),
  ServiceModel(serviceName: 'تنضيف', serviceImageUrl: '${AppAssetUrl.rootServices}/service_cleaning.png'),
  ServiceModel(serviceName: 'صباغة', serviceImageUrl: '${AppAssetUrl.rootServices}/service_tyeing.png'),
  ServiceModel(serviceName: 'خياطة', serviceImageUrl: '${AppAssetUrl.rootServices}/service_sewing.png'),
  ServiceModel(serviceName: 'قص', serviceImageUrl: '${AppAssetUrl.rootServices}/service_cutting.png'),
  ];
BillType billType=BillType.didntDeliver;

  @override
  void changeBillType(BillType type) {
    billType=type;
    update();
  }

}


enum BillType{delivered,didntDeliver,waiting}
