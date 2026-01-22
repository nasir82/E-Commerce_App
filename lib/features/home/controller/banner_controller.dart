import 'package:flutter_e_commerce_app/data/repositories/banner/banner_repository.dart';
import 'package:flutter_e_commerce_app/features/home/data/model/banner_model.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

 // variables
 final isLoading = false.obs;

 final carouselCurrentIndex = 0.obs;
 final RxList<BannerModel> banners = <BannerModel> [].obs;

 @override
 void onInit() {
    fetchBanners();
    super.onInit();
  }

 //update page navigational dots

void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
    
  }

 // fetch banners

  Future<void> fetchBanners() async{

    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();
      this.banners.assignAll(banners);
    } catch (e) {
     Loaders.errorSnackbar(title: "oh no",message: e.toString()) ;
    }finally{
      isLoading.value = false;
    }
  }


}