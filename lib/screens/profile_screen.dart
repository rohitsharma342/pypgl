import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildUserInfo(),
              _buildMenuItems(),
              _buildOrderHistory(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: 3),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Profile',
            style: AppTextStyles.heading2,
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              _showEditProfileDialog();
            },
            icon: Icon(
              Icons.edit_outlined,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserInfo() {
    return Obx(() {
      final user = userController.currentUser;
      if (user == null) {
        return Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text('Please login to view profile'),
        );
      }
      
      return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              user.name,
              style: AppTextStyles.heading3,
            ),
            SizedBox(height: 4),
            Text(
              user.email,
              style: AppTextStyles.body2,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem('Phone', user.phone),
                ),
                Expanded(
                  child: _buildInfoItem('Address', user.address),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
  
  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.body2,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
  
  Widget _buildMenuItems() {
    final menuItems = [
      {
        'icon': Icons.favorite_outline,
        'title': 'Wishlist',
        'subtitle': 'Your saved items',
        'onTap': () => Get.toNamed('/wishlist'),
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Addresses',
        'subtitle': 'Manage your addresses',
        'onTap': () {},
      },
      {
        'icon': Icons.payment_outlined,
        'title': 'Payment Methods',
        'subtitle': 'Manage payment methods',
        'onTap': () {},
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications',
        'subtitle': 'Notification preferences',
        'onTap': () {},
      },
      {
        'icon': Icons.help_outline,
        'title': 'Help & Support',
        'subtitle': 'Get help and support',
        'onTap': () {},
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'title': 'Privacy Policy',
        'subtitle': 'Read our privacy policy',
        'onTap': () {},
      },
    ];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: AppColors.primary,
            ),
            title: Text(
              item['title'] as String,
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              item['subtitle'] as String,
              style: AppTextStyles.caption,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: AppColors.grey,
            ),
            onTap: item['onTap'] as VoidCallback,
          );
        },
      ),
    );
  }
  
  Widget _buildOrderHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent Orders',
            style: AppTextStyles.heading3,
          ),
        ),
        Obx(() {
          if (userController.orderHistory.isEmpty) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 60,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userController.orderHistory.length > 3 
                  ? 3 
                  : userController.orderHistory.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final order = userController.orderHistory[index];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getStatusIcon(order.status),
                      color: _getStatusColor(order.status),
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Order ${order.id}',
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.items.length} items • \$${order.totalAmount.toStringAsFixed(2)}',
                        style: AppTextStyles.caption,
                      ),
                      Text(
                        '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
        if (userController.orderHistory.length > 3)
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'View All Orders',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
          ),
        SizedBox(height: 24),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showLogoutDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Logout',
              style: AppTextStyles.button,
            ),
          ),
        ),
      ],
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return AppColors.success;
      case 'shipped':
        return AppColors.primary;
      case 'processing':
        return AppColors.warning;
      default:
        return AppColors.grey;
    }
  }
  
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle_outline;
      case 'shipped':
        return Icons.local_shipping_outlined;
      case 'processing':
        return Icons.hourglass_empty;
      default:
        return Icons.shopping_bag_outlined;
    }
  }
  
  void _showEditProfileDialog() {
    final user = userController.currentUser;
    if (user == null) return;
    
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);
    final addressController = TextEditingController(text: user.address);
    
    Get.dialog(
      AlertDialog(
        title: Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Profile Updated',
                'Your profile has been updated successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
  
  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              userController.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}