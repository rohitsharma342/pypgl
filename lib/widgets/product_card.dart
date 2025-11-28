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

class ProductCard extends StatefulWidget {
  final Product product;
  
  ProductCard({required this.product});
  
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with SingleTickerProviderStateMixin {
  final WishlistController wishlistController = Get.find<WishlistController>();
  final CartController cartController = Get.find<CartController>();
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: () {
        Get.to(
          () => ProductDetailsScreen(),
          arguments: widget.product,
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 300),
        );
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          child: widget.product.images.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: widget.product.images.first,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: AppColors.accent,
                                    child: Center(
                                      child: Icon(
                                        Icons.diamond_outlined,
                                        size: 40,
                                        color: AppColors.primary.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: AppColors.accent,
                                    child: Center(
                                      child: Icon(
                                        Icons.diamond_outlined,
                                        size: 40,
                                        color: AppColors.primary.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  color: AppColors.accent,
                                  child: Center(
                                    child: Icon(
                                      Icons.diamond_outlined,
                                      size: 40,
                                      color: AppColors.primary.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Obx(() => GestureDetector(
                            onTap: () => wishlistController.toggleWishlist(widget.product),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.95),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                wishlistController.isInWishlist(widget.product.id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: wishlistController.isInWishlist(widget.product.id)
                                    ? AppColors.error
                                    : AppColors.grey,
                                size: 18,
                              ),
                            ),
                          )),
                        ),
                        if (!widget.product.isInStock)
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Out of Stock',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
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
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: AppTextStyles.body1.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.product.category,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.grey.withOpacity(0.8),
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: widget.product.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 12.0,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '(${widget.product.reviewCount})',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 10,
                                  color: AppColors.grey.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${widget.product.price.toStringAsFixed(2)}',
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.product.isInStock 
                                    ? () {
                                        cartController.addToCart(widget.product);
                                        _showAddedToCartFeedback();
                                      }
                                    : null,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: widget.product.isInStock 
                                        ? LinearGradient(
                                            colors: [AppColors.primary, AppColors.secondary],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : null,
                                    color: widget.product.isInStock ? null : AppColors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: widget.product.isInStock ? [
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ] : [],
                                  ),
                                  child: Icon(
                                    Icons.add_shopping_cart_rounded,
                                    color: widget.product.isInStock 
                                        ? AppColors.white 
                                        : AppColors.grey,
                                    size: 18,
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
        },
      ),
    );
  }
  
  void _showAddedToCartFeedback() {
    Get.snackbar(
      'Added to Cart',
      '${widget.product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(
        Icons.check_circle_rounded,
        color: AppColors.white,
      ),
    );
  }
}