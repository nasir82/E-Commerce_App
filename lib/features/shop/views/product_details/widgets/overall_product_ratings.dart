
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/progress_indicator.dart';

class OverAllProductRating extends StatelessWidget {
  const OverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text("4.8",style: Theme.of(context).textTheme.displayLarge,)),
        const Expanded(
          flex: 8,
          child: Column(
            children: [
              RatingProgressIndicator(text: "5",value: 1.0,),
              RatingProgressIndicator(text: "4",value: 0.8,),
              RatingProgressIndicator(text: "3",value: 0.6,),
              RatingProgressIndicator(text: "2",value: 0.4,),
              RatingProgressIndicator(text: "1",value: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}
