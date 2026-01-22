import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_attribute_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_varriation_model.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;

  BrandModel(
      {required this.id,
      required this.name,
      required this.image,
      this.isFeatured,
      this.productCount});

  static BrandModel empty() => BrandModel(
      id: '', name: '', image: '', isFeatured: false, productCount: 0);

  Map<String, Object?> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductCount': productCount,
      'isFeatured': isFeatured
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BrandModel.empty();
    } else {
      return BrandModel(
          id: data['Id'],
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productCount: data['ProductCount'] ?? 0,
          isFeatured: data['isFeatured'] ?? false);
    }
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      //map json to the model

      return BrandModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
          productCount: data['ProductCount'] ?? 0);
    } else {
      return BrandModel.empty();
    }
  }
}

List<ProductModel> products = [
  ProductModel(
    id: '1',
    title: "Men's Running Shoes",
    stock: 50,
    price: 120.00,
    salePrice: 100.00,
    sku: 'NIKE-RUN123',
    thumbnail:
        'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmen%20running%20shoes%20blue.jpg?alt=media&token=5d199f20-2041-4968-a6dd-25330d4a9d9d',
    productType: 'Shoes',
    categoryId: 'shoes',
    description:
        'Lightweight and breathable running shoes for maximum comfort.',
    brand: BrandModel(
        id: 'nike', name: 'Nike', image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fnike.png?alt=media&token=69bcabea-30fd-4a6a-b01f-6c995d79589e', isFeatured: true),
    images: ['nike_shoe_1.jpg', 'nike_shoe_2.jpg'],
    productAttributes: [
      ProductAttributeModel(name: 'Color', values: ['Red', 'Blue', 'Black','White']),
      ProductAttributeModel(
          name: 'Size', values: ['7', '8', '9', '10', '11', '12']),
    ],
    productVariations: [
      ProductVarriationModel(
          id: '1a',
          sku: 'NIKE-RUN123-white-7',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Frunning%20shoes%20white.webp?alt=media&token=093b7f82-41f5-4de0-9bf6-7750a01dec3a',
          price: 120.00,
          salePrice: 100.00,
          stock: 10,
          attributeValues: {'Color': 'White', 'Size': '7'}),
      ProductVarriationModel(
          id: '1a',
          sku: 'NIKE-RUN123-black-7',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmen%20running%20shoes%20black.jpg?alt=media&token=febd4140-bd75-4385-9677-6db0569195cd',
          price: 120.00,
          salePrice: 100.00,
          stock: 10,
          attributeValues: {'Color': 'Black', 'Size': '7'}),
      ProductVarriationModel(
          id: '1b',
          sku: 'NIKE-RUN123-BLUE-8',
          image:
              'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmen%20running%20shoes%20blue.jpg?alt=media&token=5d199f20-2041-4968-a6dd-25330d4a9d9d',
          price: 120.00,
          salePrice: 100.00,
          stock: 15,
          attributeValues: {'Color': 'Blue', 'Size': '8'}),
    ],
  ),
  ProductModel(
    id: '2',
    title: "Women's Casual Sneakers",
    stock: 40,
    price: 95.00,
    salePrice: 80.00,
    sku: 'ADIDAS-SNK456',
    thumbnail: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20shoes%20pink.png?alt=media&token=3f889a44-cf20-4c37-9443-8705f4e1df7e',
    productType: 'Shoes',
    categoryId: 'shoes',
    description: 'Comfortable casual sneakers, perfect for daily wear.',
    brand: BrandModel(
        id: 'adidas',
        name: 'Adidas',
        image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Faddidas%20logo.png?alt=media&token=71d444cc-2f1a-4ac2-82c5-af4eefe0b84e',
        isFeatured: true),
    images: [],
    productAttributes: [
      ProductAttributeModel(name: 'Color', values: ['White', 'Pink',"Brown"]),
      ProductAttributeModel(name: 'Size', values: ['5', '6', '7', '8', '9']),
    ],
    productVariations: [
      ProductVarriationModel(
          id: '2a',
          sku: 'ADIDAS-SNK456-WHITE-6',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwoman-shoes.jpg?alt=media&token=1608600d-97ae-4f08-9057-d35a7386ec30',
          price: 95.00,
          salePrice: 80.00,
          stock: 12,
          attributeValues: {'Color': 'Brown', 'Size': '6'}),
      ProductVarriationModel(
          id: '2b',
          sku: 'ADIDAS-SNK456-PINK-7',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20shoes%20pink.png?alt=media&token=3f889a44-cf20-4c37-9443-8705f4e1df7e',
          price: 95.00,
          salePrice: 80.00,
          stock: 10,
          attributeValues: {'Color': 'Pink', 'Size': '7'}),
    ],
  ),
  ProductModel(
    id: '3',
    title: "Men's Leather Jacket",
    stock: 30,
    price: 150.00,
    salePrice: 130.00,
    sku: 'LEVI-JKT789',
    thumbnail: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20black%20jacket%20front%20two.png?alt=media&token=29e7e63e-61c1-4b36-bf09-99834d4856e0',
    productType: 'Jacket',
    categoryId: 'clothing',
    description: 'Premium leather jacket for a stylish look.',
    brand: BrandModel(
        id: 'levis',
        name: "Levi's",
        image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Flevis%20logo.png?alt=media&token=5b476605-9b0f-458f-9b57-1c11a5d6b5b8',
        isFeatured: false),
    images: ['https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmen%20black%20jacket%20front.png?alt=media&token=7e61d220-15e7-4578-9f05-b990bd7459f4', 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20brown%20jacket%20back.png?alt=media&token=ec240de4-c84a-4277-8e25-2dd4bb295107'],
    productAttributes: [
      ProductAttributeModel(name: 'Color', values: ['Black', 'Brown']),
      ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
    ],
    productVariations: [
      ProductVarriationModel(
          id: '3a',
          sku: 'LEVI-JKT789-BLACK-M',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20black%20jacket%20front%20two.png?alt=media&token=29e7e63e-61c1-4b36-bf09-99834d4856e0',
          price: 150.00,
          salePrice: 130.00,
          stock: 8,
          attributeValues: {'Color': 'Black', 'Size': 'M'}),
      ProductVarriationModel(
          id: '3b',
          sku: 'LEVI-JKT789-BROWN-L',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20brown%20jacket%20front%20twoo.png?alt=media&token=5b86c7ed-40a1-457b-ab7b-893fedb472bb',
          price: 150.00,
          salePrice: 130.00,
          stock: 10,
          attributeValues: {'Color': 'Brown', 'Size': 'L'}),
    ],
  ),
  ProductModel(
    id: '4',
    title: "Women's Summer Dress",
    stock: 45,
    price: 60.00,
    salePrice: 50.00,
    sku: 'HNM-DRS101',
    thumbnail: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20summer%20dress%20ash.png?alt=media&token=a24bdc13-95e2-4b29-aec3-d98788dfaf84',
    productType: 'Dress',
    categoryId: 'clothing',
    description:
        'Lightweight and breathable summer dress with floral patterns.',
    brand: BrandModel(
        id: 'hm', name: 'H&M', image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fh%26m.png?alt=media&token=82c9d51b-cefe-48c1-b29c-7202ed0cadd6', isFeatured: true),
    images: ['https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20summer%20dress%20black.png?alt=media&token=83bf8639-69c6-4d8e-933b-74a6b93f4508', 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20summer%20dress%20light%20green.png?alt=media&token=811ff30a-cffe-45da-8dfa-9e131444315a'],
    productAttributes: [
      ProductAttributeModel(
          name: 'Color', values: ['Green Floral', 'Blue Floral']),
      ProductAttributeModel(name: 'Size', values: ['XS', 'S', 'M', 'L']),
    ],
    productVariations: [
      ProductVarriationModel(
          id: '4a',
          sku: 'HNM-DRS101-RED-S',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20summer%20dress%20light%20green.png?alt=media&token=811ff30a-cffe-45da-8dfa-9e131444315a',
          price: 60.00,
          salePrice: 50.00,
          stock: 10,
          attributeValues: {'Color': 'Green Floral', 'Size': 'S'}),
      ProductVarriationModel(
          id: '4b',
          sku: 'HNM-DRS101-BLUE-M',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwomen%20summer%20dress%20ash.png?alt=media&token=a24bdc13-95e2-4b29-aec3-d98788dfaf84',
          price: 60.00,
          salePrice: 50.00,
          stock: 12,
          attributeValues: {'Color': 'Blue Floral', 'Size': 'M'}),
    ],
  ),
  ProductModel(
    id: '5',
    title: "Men's Slim Fit Jeans",
    stock: 35,
    price: 70.00,
    salePrice: 60.00,
    sku: 'WRN-JNS555',
    thumbnail: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20jeans%20blue%202.png?alt=media&token=cb43c5d4-543c-479c-99ee-8a5c461985c5',
    productType: 'Jeans',
    categoryId: 'clothing',
    description: 'Comfortable and stylish slim-fit jeans for all-day wear.',
    brand: BrandModel(
        id: 'wrangler',
        name: 'Wrangler',
        image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Flevis%20logo.png?alt=media&token=5b476605-9b0f-458f-9b57-1c11a5d6b5b8',
        isFeatured: false),
    images: ['https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmens%20jeans%20blue%203.png?alt=media&token=3ba38b2d-662b-4a4d-b4c8-5c8002e61eaf', 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fment%20jeans%20blue%20.png?alt=media&token=7172c1b3-deba-4daf-93fb-c419ee8c2ac6'],
    productAttributes: [
      ProductAttributeModel(name: 'Color', values: ['Blue', 'Black']),
      ProductAttributeModel(
          name: 'Size', values: ['28', '30', '32', '34', '36']),
    ],
    productVariations: [
      ProductVarriationModel(
          id: '5a',
          sku: 'WRN-JNS555-BLUE-30',
          image: 'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fment%20jeans%20blue%20.png?alt=media&token=7172c1b3-deba-4daf-93fb-c419ee8c2ac6',
          price: 70.00,
          salePrice: 60.00,
          stock: 9,
          attributeValues: {'Color': 'Blue', 'Size': '30'})
    ],
  ),
];
