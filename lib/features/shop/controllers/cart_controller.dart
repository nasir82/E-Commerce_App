
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/variation_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

 static CartController get instance => Get.find();

 //variables 
 RxInt noOfCartItems = 0.obs;
 RxDouble totalCartPrice  = 0.0.obs;
 RxInt productQuantityInCart = 0.obs;
 RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
 final variationController = VariationController.instance;

 CartController(){
  loadCartItems();
 }

 // add items to the cart 

 void addToCart(ProductModel product){
  print("Called the function");
  //quantity check
  if(productQuantityInCart.value<1){
    Loaders.customToast(message: 'select quantity');
    return;
  }
  //variation selected?
  if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
     Loaders.customToast(message: 'select variation');
    return;
  }
  // out of stock?
  if(product.productType == ProductType.variable.toString()){
    if(variationController.selectedVariation.value.stock<1){
      Loaders.warnigSnackbar(title: "Warning",message: "Product is out of stock");
      return;
    }
  }else{
    if(product.stock< 1){
       Loaders.warnigSnackbar(title: "Warning",message: "Product is out of stock");
      return;
    }
  }

  final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

  int index = cartItems.indexWhere(
    (cartItem) => cartItem.productId == selectedCartItem.productId && cartItem.variationId == selectedCartItem.variationId
  );

  if(index>=0){
    // already added in the cart

    cartItems[index].quantity = selectedCartItem.quantity;

  }else{
    cartItems.add(selectedCartItem);
  }

  updateCart();
  Loaders.customToast(message: "Your product has been added t othe cart");
 }

 void addOneToCart(CartItemModel item){
  int index = cartItems.indexWhere(
    (cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId
  );

  if(index>=0){
    cartItems[index].quantity += 1;
  }else{
    cartItems.add(item);
  }
  updateCart();
 }


 void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere(
    (cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId
  );

  if(index>=0){
    if(cartItems[index].quantity>1){
      cartItems[index].quantity -= 1;
    }else{
      cartItems[index].quantity == 1 ? removeFromCartDialogue(index) : cartItems.removeAt(index);
    }
    
  }
  updateCart();
 }

 void removeFromCartDialogue(int index){
    Get.defaultDialog(
      title: "Remove Product",
      middleText: "Are your sure to remove the product",
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: "Product remove from the cart.");
        Get.back();
      },
      onCancel: ()=> ()=> Get.back(),
    );
 }

  // convert to cartitem model object
  CartItemModel convertToCartItem(ProductModel product, int quantity){
    if(product.productType == ProductType.single.name){
      // reset attributes
      variationController.resetSelectedAttribute();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isEmpty;
  
    final price  = isVariation ? product.salePrice> 0.0 ? product.salePrice : product.price : variation.salePrice>0.0 ? variation.salePrice: variation.price;
    return CartItemModel(productId: product.id, quantity: quantity,
    title: product.title,
    price: price,
    variationId: variation.id,
    image: isVariation ? variation.image : product.thumbnail,
    brandName: product.brand != null ? product.brand!.name : '',
    selectedVariation: isVariation ? variation.attributeValues : null
    );

  }

  void updateCart(){
    updateCartTotals();
    saveCartItem();
    cartItems.refresh();

  }

  void updateCartTotals(){
    double calculatedTotalPrice = 0.0;
    int calculatedNoItems = 0;
    for(var item in cartItems){
      calculatedTotalPrice += item.price * item.quantity.toDouble();
      calculatedNoItems +=item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoItems;
  }

  void saveCartItem(){
    final cartItemString = cartItems.map((item)=> item.toJson()).toList();
    LocalStorageHelper.instance().saveData('cartItems', cartItemString);
  }

  void loadCartItems(){
    final cartItemStrings = LocalStorageHelper.instance().readData<List<dynamic>>('cartItems');
    if(cartItemStrings != null){
      cartItems.assignAll(cartItemStrings.map((item)=>CartItemModel.fromJson(item as Map<String,dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId){
    final foundItem = cartItems.where(
      (item)=> item.productId == productId
    ).fold(0, (previousValue,element)=> previousValue + element.quantity);
    return foundItem;
  }

    int getVariationQuantityInCart(String productId, String variationId){
    final foundItem = cartItems.firstWhere(
      (item)=> item.productId == productId && item.variationId == variationId,
      orElse:()=> CartItemModel.empty()
    );
    return foundItem.quantity;
  }

  void clear(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }


  //update already added product count

  void updateAlreadyAddedProductCount(ProductModel product){
    //if product have no variation then calculate cart entries and display total
    //else make default entries to 0 and show cartEntries when variation is selected

    if(product.productType==ProductType.single.name){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }else{
      // get selected quantity if any
        final variationId = variationController.selectedVariation.value.id;
        if(variationId.isNotEmpty){
          productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);

        }else{
          productQuantityInCart.value =0;
        }
      //
    }
  }


  Future<void> loadDummyData() async{
    final db = FirebaseFirestore.instance;  

    await db.collection("Products").doc().set(products[0].toJson());
    await db.collection("Products").doc().set(products[1].toJson());
    await db.collection("Products").doc().set(products[2].toJson());
    await db.collection("Products").doc().set(products[3].toJson());
    await db.collection("Products").doc().set(products[4].toJson());

    print("###########################\n\n\n\n loaded dummy  \n\n #######");
  }
}