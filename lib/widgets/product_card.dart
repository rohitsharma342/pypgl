import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../models/product.dart';
import '../controllers/wishlist_controller.dart';
import '../controllers/cart_controller.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final WishlistController wishlistController = Get.find<WishlistController>();
  final CartController cartController = Get.find<CartController>();
  
  ProductCard({required this.product});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailsScreen(),
          arguments: product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.lightGrey,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.lightGrey,
                        child: Icon(
                          Icons.error,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() => GestureDetector(
                      onTap: () => wishlistController.toggleWishlist(product),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          wishlistController.isInWishlist(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: wishlistController.isInWishlist(product.id)
                              ? AppColors.error
                              : AppColors.grey,
                          size: 20,
                        ),
                      ),
                    )),
                  ),
                  if (!product.isInStock)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Out of Stock',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.category,
                      style: AppTextStyles.caption,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: product.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 12.0,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${product.reviewCount})',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: product.isInStock 
                              ? () => cartController.addToCart(product)
                              : null,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: product.isInStock 
                                  ? AppColors.primary 
                                  : AppColors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}