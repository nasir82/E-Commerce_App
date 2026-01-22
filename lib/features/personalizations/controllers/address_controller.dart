import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/data/repositories/address/address_model.dart';
import 'package:flutter_e_commerce_app/data/repositories/address/address_repository.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/new_address.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/widgets/single_address.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final addressRepo = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepo.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
          print(addresses);
      return addresses;
    } catch (e) {
      Loaders.errorSnackbar(title: "Address not found", message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel address) async {
    try {
      //clear selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }
      // assign selected address
      address.selectedAddress = true;
      selectedAddress.value = address;

      // set selected field true
      await addressRepo.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      print("${e}my message ${selectedAddress.value.id}");
      throw 'Unable to change your selection. Try again';
    }
  }

  Future addNewAddress() async {
    try {
      FullScreenloader.openLoadingDialogue(
          "Storing address", ImageString.successLotie);
      // network connectivity check
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }
      if (!addressFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);

          final id = await addressRepo.addAddress(address);
          address.id = id;
          await selectAddress(address);
          FullScreenloader.stopLoading();
          Loaders.succesSnackbar(title: "Congratulations", message: "Your address has been saved succecssfully.");

          refreshData.toggle();
          
          resetFormField();

          //redirect
          Navigator.of(Get.context!).pop();

    } catch (e) {

        FullScreenloader.stopLoading();
        print(e.toString());
        throw 'Unable to save the address';

    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context){

    return showModalBottomSheet(context: context, 
    builder: (_) => Container(

      padding: const EdgeInsets.all(Sizes.lg),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: "Select Address",isShowButton: false,),
            FutureBuilder(
              future: allUserAddresses(),
             builder: (_,snapshot){
              final response = CloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot);
              if(response != null) return response;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
        
                itemBuilder: (_,index)=> SingleAddress(address: snapshot.data![index], onTap: () async{
                  print("This is bla bla \n \n \n \n");
                  await selectAddress(snapshot.data![index]);
                  Get.back();
                })
                );
             }
             ),
             const SizedBox(
              height: Sizes.defaultSpace * 2,
             ),
             SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=> Get.to(()=> const CreateNewAddress()), child: const Text("Add New Address")),
             )
          ],
        ),
      ),
    )
    
    
    );
  }
  void resetFormField(){
    name.clear();
    phoneNumber.clear();
    state.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  
  }
}
