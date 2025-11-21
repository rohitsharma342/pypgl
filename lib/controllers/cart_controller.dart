import 'package:get/get.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  
  List<CartItem> get cartItems => _cartItems;
  
  int get itemCount => _cartItems.length;
  
  double get totalAmount {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  void addToCart(Product product) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
    
    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }
  
  void updateQuantity(String productId, int quantity) {
    final itemIndex = _cartItems.indexWhere((item) => item.product.id == productId);
    if (itemIndex >= 0) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else {
        _cartItems[itemIndex].quantity = quantity;
      }
    }
  }
  
  void clearCart() {
    _cartItems.clear();
  }
  
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }
}