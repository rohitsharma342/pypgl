import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../controllers/cart_controller.dart';
import '../widgets/custom_bottom_nav.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTextStyles.heading3,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.black),
        ),
        actions: [
          Obx(() => cartController.itemCount > 0 
              ? TextButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text('Clear Cart'),
                        content: Text('Are you sure you want to remove all items from your cart?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              cartController.clearCart();
                              Get.back();
                            },
                            child: Text('Clear', style: TextStyle(color: AppColors.error)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Clear All',
                    style: TextStyle(color: AppColors.error),
                  ),
                )
              : SizedBox(),
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.itemCount == 0) {
          return _buildEmptyCart();
        }
        
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartController.cartItems[index];
                  return _buildCartItem(cartItem);
                },
              ),
            ),
            _buildCheckoutSection(),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNav(currentIndex: 2),
    );
  }
  
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.grey,
          ),
          SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Add some items to get started',
            style: AppTextStyles.body2,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCartItem(cartItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: cartItem.product.images.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.lightGrey,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.lightGrey,
                  child: Icon(Icons.error, color: AppColors.error),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    cartItem.product.category,
                    style: AppTextStyles.caption,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (cartItem.quantity > 1) {
                          cartController.updateQuantity(
                            cartItem.product.id,
                            cartItem.quantity - 1,
                          );
                        }
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: cartItem.quantity > 1 
                              ? AppColors.lightGrey 
                              : AppColors.lightGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16,
                          color: cartItem.quantity > 1 
                              ? AppColors.black 
                              : AppColors.grey,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '${cartItem.quantity}',
                        style: AppTextStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartController.updateQuantity(
                          cartItem.product.id,
                          cartItem.quantity + 1,
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    cartController.removeFromCart(cartItem.product.id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount:',
                style: AppTextStyles.heading3,
              ),
              Obx(() => Text(
                '\$${cartController.totalAmount.toStringAsFixed(2)}',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primary,
                ),
              )),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showCheckoutDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showCheckoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Checkout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Summary:'),
            SizedBox(height: 8),
            Obx(() => Text('Items: ${cartController.itemCount}')),
            Obx(() => Text('Total: \$${cartController.totalAmount.toStringAsFixed(2)}')),
            SizedBox(height: 16),
            Text('This is a demo app. In a real app, you would proceed to payment gateway.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              cartController.clearCart();
              Get.back();
              Get.snackbar(
                'Order Placed',
                'Your order has been placed successfully!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.success,
                colorText: AppColors.white,
              );
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}