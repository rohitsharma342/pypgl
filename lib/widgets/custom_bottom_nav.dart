import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  
  CustomBottomNav({required this.currentIndex});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        onTap: (index) {
          switch (index) {
            case 0:
              if (currentIndex != 0) {
                Get.offAll(() => DashboardScreen());
              }
              break;
            case 1:
              _showWishlistBottomSheet();
              break;
            case 2:
              if (currentIndex != 2) {
                Get.to(() => CartScreen());
              }
              break;
            case 3:
              if (currentIndex != 3) {
                Get.to(() => ProfileScreen());
              }
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.favorite_outline),
                Obx(() => wishlistController.itemCount > 0
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${wishlistController.itemCount}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(),
                ),
              ],
            ),
            activeIcon: Stack(
              children: [
                Icon(Icons.favorite),
                Obx(() => wishlistController.itemCount > 0
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${wishlistController.itemCount}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(),
                ),
              ],
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Obx(() => cartController.itemCount > 0
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${cartController.itemCount}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(),
                ),
              ],
            ),
            activeIcon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Obx(() => cartController.itemCount > 0
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${cartController.itemCount}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(),
                ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  
  void _showWishlistBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'My Wishlist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Obx(() {
                if (wishlistController.itemCount == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 80,
                          color: AppColors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Your wishlist is empty',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Save items you love to view them later',
                          style: TextStyle(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: wishlistController.wishlistItems.length,
                  itemBuilder: (context, index) {
                    final product = wishlistController.wishlistItems[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.images.first,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: AppColors.lightGrey,
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: product.isInStock
                                    ? () => cartController.addToCart(product)
                                    : null,
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: product.isInStock
                                      ? AppColors.primary
                                      : AppColors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () => wishlistController.removeFromWishlist(product.id),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}