import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/circuler_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/change_name.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const MyAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : ImageString.products;
                      return controller.isLoadingImage.value
                          ? const MyShimmerEffect(
                              height: 80,
                              width: 80,
                              radius: 80,
                            )
                          : CirculerImage(
                              image: image,
                              height: 150,
                              width: 150,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),

              // details

              const SizedBox(
                height: Sizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems / 2,
              ),

              const SectionHeading(title: "Profile Information"),

              const SizedBox(
                height: Sizes.spaceBtwItems / 2,
              ),
              ProfileMenu(
                title: "Name ",
                value: controller.user.value.fullname,
                onPressed: () => Get.off(const ChangeName()),
              ),
              ProfileMenu(
                title: "username ",
                value: controller.user.value.userName,
                onPressed: () {},
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              const SectionHeading(title: "Personal Information"),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: "E-mail ",
                value: controller.user.value.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: "Phone ",
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              ProfileMenu(
                title: "Gender ",
                value: "Male",
                onPressed: () {},
              ),
              ProfileMenu(
                title: "DOT ",
                value: "31 Dec, 2001",
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              TextButton(
                  onPressed: () => AuthenticationRepository.instance.logOut(),
                  child: const Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 6,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                child: Icon(
              icon,
              size: 18,
            ))
          ],
        ),
      ),
    );
  }
}
