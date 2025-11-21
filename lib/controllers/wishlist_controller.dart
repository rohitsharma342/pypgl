import 'package:get/get.dart';
import '../models/product.dart';

class WishlistController extends GetxController {
  final RxList<Product> _wishlistItems = <Product>[].obs;
  
  List<Product> get wishlistItems => _wishlistItems;
  
  int get itemCount => _wishlistItems.length;
  
  void toggleWishlist(Product product) {
    final isInWishlist = _wishlistItems.any((item) => item.id == product.id);
    
    if (isInWishlist) {
      _wishlistItems.removeWhere((item) => item.id == product.id);
      Get.snackbar(
        'Removed from Wishlist',
        '${product.name} has been removed from your wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _wishlistItems.add(product);
      Get.snackbar(
        'Added to Wishlist',
        '${product.name} has been added to your wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }
  
  void removeFromWishlist(String productId) {
    _wishlistItems.removeWhere((item) => item.id == productId);
  }
  
  void clearWishlist() {
    _wishlistItems.clear();
  }
}