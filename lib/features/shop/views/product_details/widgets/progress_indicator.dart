
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key, required this.text, required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          flex: 1,
          child: Text(text,style: Theme.of(context).textTheme.bodyMedium,)),
         Expanded(
          flex: 11,
           child: SizedBox(
            width: DeviceUtils.getScreenWidth(context) * 0.8,
             child: LinearProgressIndicator(
              value: value,
              minHeight: 12,
              backgroundColor: MyColor.grey,
              valueColor: const AlwaysStoppedAnimation(MyColor.primaryColor),
              borderRadius: BorderRadius.circular(6),
             ),
           ),
         )
                        
      ],
    );
  }
}