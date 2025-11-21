import 'package:get/get.dart';
import '../models/user.dart';
import '../models/order.dart';
import '../services/data_service.dart';

class UserController extends GetxController {
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxList<Order> _orderHistory = <Order>[].obs;
  
  User? get currentUser => _currentUser.value;
  List<Order> get orderHistory => _orderHistory;
  
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  
  void loadUserData() {
    _currentUser.value = DataService.getCurrentUser();
    _orderHistory.value = DataService.getUserOrders();
  }
  
  void updateUser(User user) {
    _currentUser.value = user;
  }
  
  void logout() {
    _currentUser.value = null;
    _orderHistory.clear();
    Get.offAllNamed('/dashboard');
  }
  
  void addOrder(Order order) {
    _orderHistory.insert(0, order);
  }
}