import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
    
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => DashboardScreen());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.diamond,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Pypgl',
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.white,
                        fontSize: 36,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Made With BrainBox',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 40),
                    CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}