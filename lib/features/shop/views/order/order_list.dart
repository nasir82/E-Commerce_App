// import 'package:flutter/material.dart';
// import 'package:flutter_e_commerce_app/commons/widgets/loader/animation_loader.dart';
// import 'package:flutter_e_commerce_app/features/home/widgets/my_circulercontainer.dart';
// import 'package:flutter_e_commerce_app/features/shop/controllers/order_controller.dart';
// import 'package:flutter_e_commerce_app/navigation/navigaton_menu.dart';
// import 'package:flutter_e_commerce_app/utils/constants/color.dart';
// import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
// import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
// import 'package:flutter_e_commerce_app/utils/helpers/cloud_helper_functions.dart';
// import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class ToOrderListItem extends StatelessWidget {
//   const ToOrderListItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrderController());

//     final dark = HelperFunctions.isDarkMood(context);

//     return FutureBuilder(
//       future: controller.fetchUserOrders(),
//       builder: (context, snapshot) {
//         final emptyWidget = AnimationLoaderWidget(text: "oops your have no order yet.", animation: ImageString.successLotie, showAction: true, actionText: "Let\'s fill it.",onActionClick:()=> Get.off(()=> const NavigationMenu(),));

//         final response = CloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot,nothingFound: emptyWidget);
//         if(response != null) return response;
//         final orders = snapshot.data!;
//         print(orders);
//         return ListView.separated(
//           shrinkWrap: true,
//           separatorBuilder: (_, __) => const SizedBox(
//             height: Sizes.spaceBtwItems,
//           ),
//           itemCount: orders.length,
//           itemBuilder: (_, index) {
//             final order = orders[index];
//             print(order);
//              MyCirculerContainer(
//             showBorder: true,
//             padding: const EdgeInsets.all(Sizes.md),
//             backgroundColor: dark ? MyColor.dark : MyColor.light,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(children: [
//                   const Icon(Iconsax.ship),
//                   const SizedBox(
//                     width: Sizes.spaceBtwItems / 2,
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           order.status.name,
//                           style: Theme.of(context).textTheme.bodyLarge!.apply(
//                               color: MyColor.primaryColor, fontWeightDelta: 1),
//                         ),
//                         Text(
//                           "12 jul, 2024",
//                             style: Theme.of(context).textTheme.headlineSmall),
//                       ],
//                     ),
//                   ),
//                   const Icon(Iconsax.arrow_right_34)
//                 ]),
//                 const SizedBox(
//                   height: Sizes.spaceBtwItems,
//                 ),
//                 Row(children: [
//                   Expanded(
//                     child: Row(
//                       children: [
//                         const Icon(Iconsax.tag),
//                         const SizedBox(
//                           width: Sizes.spaceBtwItems / 2,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Order",
//                                 style: Theme.of(context).textTheme.labelMedium,
//                               ),
//                               Text(
//                                 "154613",
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       children: [
//                         const Icon(Iconsax.calendar),
//                         const SizedBox(
//                           width: Sizes.spaceBtwItems / 2,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Shipping date",
//                                 style: Theme.of(context).textTheme.labelMedium,
//                               ),
//                               Text(
//                                 "12 july, 2024",
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ]),
//               ],
//             ),
//           );
//       }
//         );
//       }
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/loader/animation_loader.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/order_controller.dart';
import 'package:flutter_e_commerce_app/navigation/navigaton_menu.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ToOrderListItem extends StatelessWidget {
  const ToOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = HelperFunctions.isDarkMood(context);

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        /// Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        /// Handle error state
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        /// Handle empty orders case
        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return AnimationLoaderWidget(
            text: "Oops! You have no orders yet.",
            animation: ImageString.successLotie,
            showAction: true,
            actionText: "Let's fill it.",
            onActionClick: () => Get.off(() => const NavigationMenu()),
          );
        }

        final orders = snapshot.data as List; // Ensure data is cast correctly
        orders.sort((a,b)=> a=b.orderDate.compareTo(a.orderDate));
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
          itemCount: orders.length,
          itemBuilder: (_, index) {
            final order = orders[index];

            return MyCirculerContainer(
              showBorder: true,
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: dark ? MyColor.dark : MyColor.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.ship),
                      const SizedBox(width: Sizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "pending",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: MyColor.primaryColor, fontWeightDelta: 1),
                            ),
                            Text(
                              order.formattedOrderDate, // Use formatted order date
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Iconsax.arrow_right_34),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: Sizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order",
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id, // Ensure you display the correct order ID
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: Sizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping date",
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate.isNotEmpty
                                        ? order.formattedDeliveryDate
                                        : "Not Assigned",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
