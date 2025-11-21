import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../models/product.dart';
import '../services/data_service.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/filter_modal.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  List<String> categories = [];
  String selectedCategory = 'All';
  String searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  void loadData() {
    allProducts = DataService.getProducts();
    categories = DataService.getCategories();
    filteredProducts = allProducts;
  }
  
  void filterProducts() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final matchesCategory = selectedCategory == 'All' || product.category == selectedCategory;
        final matchesSearch = searchQuery.isEmpty || 
            product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            product.description.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }
  
  void onSearchChanged(String query) {
    searchQuery = query;
    filterProducts();
  }
  
  void onCategorySelected(String category) {
    selectedCategory = category;
    filterProducts();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryTabs(),
            Expanded(
              child: filteredProducts.isEmpty ? _buildEmptyState() : _buildProductGrid(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: 0),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,', style: AppTextStyles.body2),
              Text('Welcome to Pypgl', style: AppTextStyles.heading2),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined, size: 28),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => Stack(
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/cart'),
                    icon: Icon(Icons.shopping_bag_outlined, size: 28),
                  ),
                  if (cartController.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartController.itemCount}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search jewelry...',
                  hintStyle: AppTextStyles.body2,
                  prefixIcon: Icon(Icons.search, color: AppColors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => FilterModal(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
              child: Text(
                category,
                style: AppTextStyles.body1.copyWith(
                  color: isSelected ? AppColors.white : AppColors.darkGrey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: filteredProducts[index]);
      },
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: AppTextStyles.body2,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All';
                searchQuery = '';
                _searchController.clear();
                filterProducts();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}