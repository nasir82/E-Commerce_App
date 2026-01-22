import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/sortable_product.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/all_product_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/vertical_product_shimmer.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: FutureBuilder(
                future: futureMethod ?? controller.getAllProduct(),
                builder: (context, snapshot) {

                  // cloud helper function used in this later
                  const loader = VerticalProductShimmer();
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return loader;
                  }
                  if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("No Data available")
                    );
                  }
                  if(snapshot.hasError){
                    return const Center(
                      child: Text("Something went wrong")
                    );
                  }

                  final products = snapshot.data!;
                  print("here is te produts");
                  print(products);
                  return SortableProduct(products: products,);
                })),
      ),
    );
  }
}
