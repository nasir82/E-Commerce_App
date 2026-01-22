import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/shop/views/order/order_list.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar(
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.bodyMedium,
          
        ),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(Sizes.defaultSpace),
        child: ToOrderListItem(),
      )
    );
  }
}