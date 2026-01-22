import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/data/repositories/address/address_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/formatters/formatters.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime? orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel(
      {required this.id,
      this.userId = '',
      required this.status,
      required this.items,
      required this.totalAmount,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.address,
      this.deliveryDate});

  String get formattedOrderDate => MyFormatter.formateDate(orderDate);
  String get formattedDeliveryDate =>
      deliveryDate != null ? MyFormatter.formateDate(deliveryDate) : '';
  String get orderStatus =>
      status == OrderStatus.shipped.name ? 'Shipment on the way' : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.name,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((e) => e.toJson()).toList()
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>? ?? {}; // Ensure data is not null

  return OrderModel(
    id: data['id'] as String? ?? '',
    userId: data['userId'] as String? ?? '',
    status: OrderStatus.values.firstWhere(
      (e) => e.name == (data['status'] as String? ?? ''),
      orElse: () => OrderStatus.pending, // Default to pending if missing
    ),
    totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
    orderDate: (data['orderDate'] is Timestamp)
        ? (data['orderDate'] as Timestamp).toDate()
        : null, // Ensuring safe conversion
    paymentMethod: data['paymentMethod'] as String? ?? 'Paypal',
    address: (data['address'] is Map<String, dynamic>)
        ? AddressModel.forMap(data['address'] as Map<String, dynamic>)
        : null,
    deliveryDate: (data['deliveryDate'] is Timestamp)
        ? (data['deliveryDate'] as Timestamp).toDate()
        : null,
    items: (data['items'] is List)
        ? (data['items'] as List)
            .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [],
  );
}

}
