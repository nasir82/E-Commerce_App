import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class CuponCode extends StatelessWidget {
  const CuponCode({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return MyCirculerContainer(
      showBorder: true,
      backgroundColor: dark ? MyColor.darkerGrey : MyColor.light,
      padding: const EdgeInsets.only(
        top: Sizes.sm,
        bottom: Sizes.sm,
        right: Sizes.sm,
        left: Sizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Have a cupon code? Enter here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Apply"))
        ],
      ),
    );
  }
}
