
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/circle_icon.dart';
import 'package:flutter_e_commerce_app/features/home/views/home.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_cards/product_cartvertical.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/favourite_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/vertical_product_shimmer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return  Scaffold(
      appBar: MyAppBar(
        title: Text("Whishlist",style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          CirculerIcon(icon: Iconsax.add, onTap: ()=> Get.to(const HomeScreen()),), 
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            Obx(
              ()=> FutureBuilder(
                future: controller.favouritesProducts(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const VerticalProductShimmer(itmeCount: 6,);
                  }
              
                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                  if(snapshot.hasError){
                     return const Center(
                      child: Text("something wrong"),
                    );
                  }
                  final products = snapshot.data!;
              
                  return GridLayoutImp(itemCount: products.length, itemBuilder: (_,index){
                    return  ProductCardVertical(product: products[index],);
                  });
                }
              ),
            )
          ],
        ),),
      ),
    );
  }
}