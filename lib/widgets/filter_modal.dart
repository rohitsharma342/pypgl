import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  RangeValues _priceRange = RangeValues(0, 500);
  double _minRating = 0;
  List<String> _selectedCategories = [];
  bool _inStockOnly = false;
  
  final List<String> categories = ['Necklaces', 'Earrings', 'Bracelets', 'Rings'];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceFilter(),
                  SizedBox(height: 24),
                  _buildCategoryFilter(),
                  SizedBox(height: 24),
                  _buildRatingFilter(),
                  SizedBox(height: 24),
                  _buildAvailabilityFilter(),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Filters',
            style: AppTextStyles.heading3,
          ),
          Spacer(),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: AppTextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 500,
          divisions: 10,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.lightGrey,
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${_priceRange.start.round()}', style: AppTextStyles.body2),
            Text('\$${_priceRange.end.round()}', style: AppTextStyles.body2),
          ],
        ),
      ],
    );
  }
  
  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: AppTextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = _selectedCategories.contains(category);
            return FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.primary,
              backgroundColor: AppColors.lightGrey.withOpacity(0.3),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: AppTextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: List.generate(5, (index) {
            final rating = index + 1.0;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _minRating = rating;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _minRating >= rating 
                      ? AppColors.primary 
                      : AppColors.lightGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: _minRating >= rating 
                          ? AppColors.white 
                          : AppColors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${rating.toInt()}+',
                      style: TextStyle(
                        color: _minRating >= rating 
                            ? AppColors.white 
                            : AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
  
  Widget _buildAvailabilityFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: AppTextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        CheckboxListTile(
          title: Text('In stock only'),
          value: _inStockOnly,
          activeColor: AppColors.primary,
          onChanged: (bool? value) {
            setState(() {
              _inStockOnly = value ?? false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
  
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(20),
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
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _priceRange = RangeValues(0, 500);
                  _minRating = 0;
                  _selectedCategories.clear();
                  _inStockOnly = false;
                });
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Clear All'),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar(
                  'Filters Applied',
                  'Products filtered successfully',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}