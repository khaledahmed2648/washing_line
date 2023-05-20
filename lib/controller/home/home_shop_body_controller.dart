import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:washing_line/controller/bill_details_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/data/datasource/remote/bill_data_source.dart';
import 'package:washing_line/data/datasource/remote/customer_data_source.dart';
import 'package:washing_line/data/model/customer_model.dart';
import 'package:washing_line/preseintation/screens/add_customer_screen.dart';

import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';
import '../../core/constant/routes.dart';
import '../../data/datasource/local/sqflite.dart';
import '../../data/model/product_model.dart';
import '../../preseintation/widgets/main_widgets/custom_button.dart';
import '../../preseintation/widgets/main_widgets/custom_text_field.dart';
import 'home_controller.dart';

class HomeShopBodyController extends GetxController {
  static HomeShopBodyController instance = Get.find<HomeShopBodyController>();
  TextEditingController customerNumberController=TextEditingController();
  TextEditingController noteController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  List<LocalProductModel> shopProducts = [];
  ShopState shopState = ShopState.initial;

  SqlDb sqlDb = Get.put(SqlDb());
  getShopProducts() async {
    await sqlDb.readData("SELECT * FROM 'shop'").then((value) {
      shopProducts = [];
      value.forEach((element) {
        shopProducts.add(LocalProductModel.fromJson(element));
      });
    });
    shopState = ShopState.loaded;
    update();
  }

  updateProductQuantity(int quantity, int id) {
    sqlDb
        .updateData("UPDATE 'shop' SET productQuantity=$quantity WHERE id=$id");
  }
  List<String> items = ['لا توجد ارقام'];
  String? selectedItem='لا توجد ارقام';

  void interClientNumber(BuildContext context,bool byId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            content: Container(
              height: 400 * h(context),
              child: GetBuilder<HomeShopBodyController>(
                builder: (controller) => Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        byId?'الكود':'الهاتف',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brounColor),
                      ).marginOnly(bottom: 5 * h(context)),
                      CustomTextField(
                        onChange: (value)async{
                          if(formKey.currentState!.validate()){
                            await searchCustomerByPhone(value,byId);
                            if(searchCustomerRequest==StatusRequest.serverFailure){
                              Get.snackbar('تنبية',byId?'الكود غير صحيح':'رقم الهاتف غير صحيح');
                            }
                          }
                        },
                        controller: customerNumberController, hint:byId ?'الكود':'الهاتف',onValidate: (value){
                        if(value!.isEmpty){
                          return byId?'تأكد من الكود':'تأكد من رقم الهاتف';

                        }
                        else return null;
                      },),

                      DropdownButton<String>(

                        value: controller.selectedItem,
                        onChanged: (value) {
                          controller.selectedItem = value;
                          controller.update();
                        },
                        items: controller.items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        isExpanded: true,
                      ),
                      if(billStatus==StatusRequest.loading||searchCustomerRequest==StatusRequest.loading)
                        Center(child: CircularProgressIndicator(),),
                      if(searchCustomerRequest==StatusRequest.initialState||searchCustomerRequest==StatusRequest.serverFailure)
                        CustomButton(
                          height: 43 * h(context),
                          text: 'اضافة عميل',
                          onPressed: ()async {
                            Get.back();
                            Get.to(AddCustomerScreen());
                          },
                        ).marginOnly(top: 5),
                        CustomButton(
                          height: 43 * h(context),
                          text: 'انشاء فاتورة',
                          onPressed: ()async {
                            if(selectedItem!='لا توجد ارقام'){
                              await createBill(byId);
                            }else{
                              Get.defaultDialog(title:'تنبية',middleText: 'لم تختر رقم بعد');

                            }
                          },
                        ).marginOnly(top: 5),


                    ],
                  ),
                ),
              ),
            ),
          );
        }
        ).then((value) {
      items = ['لا توجد ارقام'];
      customerNumberController.clear();
      items = ['لا توجد ارقام'];
      searchCustomerRequest=StatusRequest.initialState;
      selectedItem='لا توجد ارقام';
      noteController.clear();
      billStatus=StatusRequest.initialState;
      update();
    });

  }

  void _confirmBill(BuildContext context) {
    sqlDb.deleteTable('shop');
    getShopProducts();
    Get.back();
    update();
    Get.toNamed(AppRoutes.billdetailsScreen);
  }

  void _search(BuildContext context) {}
  deleteShop() async {
    sqlDb.deleteTable('shop');
    shopProducts=[];
    update();
  }

  confirmDeleteProduct(
      void Function() confirmOnPressed, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('هل تريد حذف العنصر من السلة'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'لا',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: confirmOnPressed,
            child: Text(
              'نعم',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
  StatusRequest searchCustomerRequest=StatusRequest.initialState;
 CustomerModel? customerModel;
  deleteProduct(int productId, int index) {
    sqlDb.deleteData(
      'DELETE FROM shop WHERE productId = $productId',
    );
    shopProducts.removeAt(index);
    update();
  }
  searchCustomerByPhone(String phoneOrCode,bool byId)async{
    searchCustomerRequest=StatusRequest.loading;
    update();
    dio.Response response;
    if(byId==false){
      response=await CustomerDataSource.searchCustomerByPhone(phoneOrCode);
      if(response.data['data'].isEmpty){
        if(searchCustomerRequest!=StatusRequest.serverFailure){
          items = ['لا توجد ارقام'];
          selectedItem='لا توجد ارقام';
          searchCustomerRequest=StatusRequest.serverFailure;
        }
      }else{
        customerModel=CustomerModel.fromJson(response.data);
        items=customerModel!.data!.map((e) => e.phone!).toList();
        selectedItem=customerModel!.data![0].phone!;
        searchCustomerRequest=StatusRequest.success;
      }
      print(response.data);
    }
    else{
      response=await CustomerDataSource.searchCustomerByCode(phoneOrCode);
      if(response.data['data'].isEmpty){
        if(searchCustomerRequest!=StatusRequest.serverFailure)
          items = ['لا توجد ارقام'];
        selectedItem='لا توجد ارقام';
        searchCustomerRequest=StatusRequest.serverFailure;
      }else{
        customerModel=CustomerModel.fromJson(response.data);
        items=customerModel!.data!.map((e) => e.phone!).toList();
        selectedItem=customerModel!.data![0].phone!;
        searchCustomerRequest=StatusRequest.success;
      }
      print(response.data);
    }

    update();
  }

  StatusRequest billStatus=StatusRequest.initialState;
  createBill(bool byId)async{
    if(shopProducts!=[]){
      billStatus=StatusRequest.loading;
      update();
      List<int> productsIds=shopProducts.map((e) => e.productId).toList();
      List<int> productsQuantities=shopProducts.map((e) => e.productQuantity).toList();
      int x=0,y=0;
      Map<String, String> productsMap = Map.fromIterable(
        productsIds,
        key: (index) =>'products_ids[${x++}]'.toString() ,
        value: (productId) =>productId.toString(),
      );
      productsMap.addAll(Map.fromIterable(
        productsQuantities,
        key: (index) =>'quantities[${y++}]'.toString() ,
        value: (productQuantity) =>productQuantity.toString(),
      ));
      productsMap['customer_id']=customerModel!.data![items.indexOf(selectedItem!)].id.toString();
      if(noteController.text.isNotEmpty)productsMap['notes']=noteController.text;
      print('============================productmaps================');
      print(productsMap);
      var response=await BillDataSource.addToBill(productsMap);
      if(response.data['success']==true){
        Get.back();
        deleteShop();
        int billId=response.data['data']['bill_id'];
        Get.defaultDialog(title:'شكرا لك',middleText: 'تم انشاء الفاتورة بنجاح').then((value)async {

          Get.back();
          Get.toNamed(AppRoutes.billdetailsScreen,arguments: {'billId':billId.toString()});
        });

      }else{
        Get.defaultDialog(title:'تنبية',middleText: 'هناك مشكلة في المنتجات المرسلة');

      }
      update();
    }else{
      Get.defaultDialog(title:'تنبية',middleText: 'لم تقم باضافة اي عناصر');

    }

  }
  }