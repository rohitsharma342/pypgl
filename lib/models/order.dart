import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final String status;
  final String shippingAddress;
  
  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.shippingAddress,
  });
}