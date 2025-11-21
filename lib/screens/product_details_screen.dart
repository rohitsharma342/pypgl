import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  late Product product;
  int currentImageIndex = 0;
  
  @override
  void initState() {
    super.initState();
    product = Get.arguments as Product;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductInfo(),
                _buildDescription(),
                _buildReviews(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
  
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: AppColors.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back, color: AppColors.black),
        ),
      ),
      actions: [
        Obx(() => IconButton(
          onPressed: () => wishlistController.toggleWishlist(product),
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              wishlistController.isInWishlist(product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: wishlistController.isInWishlist(product.id)
                  ? AppColors.error
                  : AppColors.black,
            ),
          ),
        )),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            PageView.builder(
              itemCount: product.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentImageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: product.images[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.lightGrey,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.lightGrey,
                    child: Icon(Icons.error, color: AppColors.error),
                  ),
                );
              },
            ),
            if (product.images.length > 1)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: product.images.asMap().entries.map((entry) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentImageIndex == entry.key
                            ? AppColors.primary
                            : AppColors.white.withOpacity(0.5),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProductInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: AppTextStyles.heading2,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              RatingBarIndicator(
                rating: product.rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
              ),
              SizedBox(width: 8),
              Text(
                '(${product.reviewCount} reviews)',
                style: AppTextStyles.body2,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: product.isInStock ? AppColors.success : AppColors.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.isInStock ? 'In Stock' : 'Out of Stock',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.heading3,
          ),
          SizedBox(height: 12),
          Text(
            product.description,
            style: AppTextStyles.body1.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviews() {
    if (product.reviews.isEmpty) {
      return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Reviews',
              style: AppTextStyles.heading3,
            ),
            SizedBox(height: 12),
            Text(
              'No reviews yet. Be the first to review this product!',
              style: AppTextStyles.body2,
            ),
          ],
        ),
      );
    }
    
    return Container(
      margin: EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Customer Reviews (${product.reviews.length})',
              style: AppTextStyles.heading3,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: product.reviews.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final review = product.reviews[index];
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.userName,
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        RatingBarIndicator(
                          rating: review.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      review.comment,
                      style: AppTextStyles.body1,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${review.date.day}/${review.date.month}/${review.date.year}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomBar() {
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
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: product.isInStock 
                  ? () => cartController.addToCart(product)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: AppColors.grey,
              ),
              child: Text(
                product.isInStock ? 'Add to Cart' : 'Out of Stock',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}