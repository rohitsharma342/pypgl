import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';
import 'controllers/user_controller.dart';
import 'screens/splash_screen.dart';
import 'constants/colors.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    Get.put(WishlistController());
    Get.put(UserController());
    
    return GetMaterialApp(
      title: 'Pypgl',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF00BDB5, {
          50: Color(0xFFE0F7F6),
          100: Color(0xFFB3ECEB),
          200: Color(0xFF80DFDE),
          300: Color(0xFF4DD2D0),
          400: Color(0xFF26C8C5),
          500: Color(0xFF00BDB5),
          600: Color(0xFF00B7AE),
          700: Color(0xFF00AEA5),
          800: Color(0xFF00A69C),
          900: Color(0xFF00998B),
        }),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
      home: SplashScreen(),
      getPages: AppRoutes.routes,
    );
  }
}