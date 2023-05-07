import 'package:flutter/material.dart';
import 'package:washing_line/core/services/services.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/date_bills_item.dart';
import 'package:washing_line/preseintation/widgets/product_details_item.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          // MyServices.sharedPreferences.se
        },
        // child: ProductDetailsItem(quantity: 5,minusOnPressed: (){},addOnPressed: (){},),
      ),
    );
  }
}
