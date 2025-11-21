import '../models/product.dart';
import '../models/user.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

class DataService {
  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: 'Golden Chain Necklace',
        description: 'Beautiful golden chain necklace perfect for any occasion. Made with high-quality artificial gold that maintains its shine.',
        price: 299.99,
        images: [
          'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800',
          'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800',
        ],
        category: 'Necklaces',
        rating: 4.5,
        reviewCount: 128,
        isInStock: true,
        reviews: [
          Review(
            id: '1',
            userName: 'Sarah Johnson',
            rating: 5.0,
            comment: 'Absolutely beautiful! The quality is amazing for the price.',
            date: DateTime.now().subtract(Duration(days: 5)),
          ),
          Review(
            id: '2',
            userName: 'Emma Wilson',
            rating: 4.0,
            comment: 'Good quality but delivery was a bit slow.',
            date: DateTime.now().subtract(Duration(days: 12)),
          ),
        ],
      ),
      Product(
        id: '2',
        name: 'Pearl Drop Earrings',
        description: 'Elegant pearl drop earrings that add sophistication to any outfit. Perfect for both casual and formal occasions.',
        price: 149.99,
        images: [
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=800',
          'https://images.unsplash.com/photo-1588444837495-c6cfeb53071d?w=800',
        ],
        category: 'Earrings',
        rating: 4.8,
        reviewCount: 95,
        isInStock: true,
        reviews: [
          Review(
            id: '3',
            userName: 'Lisa Brown',
            rating: 5.0,
            comment: 'These earrings are stunning! Perfect size and very comfortable.',
            date: DateTime.now().subtract(Duration(days: 3)),
          ),
        ],
      ),
      Product(
        id: '3',
        name: 'Silver Charm Bracelet',
        description: 'Delicate silver charm bracelet with beautiful hanging charms. Adjustable size to fit most wrists comfortably.',
        price: 199.99,
        images: [
          'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=800',
          'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=800',
        ],
        category: 'Bracelets',
        rating: 4.3,
        reviewCount: 76,
        isInStock: false,
        reviews: [],
      ),
      Product(
        id: '4',
        name: 'Diamond Statement Ring',
        description: 'Stunning statement ring with artificial diamonds. Perfect for special occasions and making a bold fashion statement.',
        price: 399.99,
        images: [
          'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800',
          'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=800',
        ],
        category: 'Rings',
        rating: 4.7,
        reviewCount: 203,
        isInStock: true,
        reviews: [
          Review(
            id: '4',
            userName: 'Maria Garcia',
            rating: 5.0,
            comment: 'Absolutely gorgeous! Gets compliments everywhere I go.',
            date: DateTime.now().subtract(Duration(days: 8)),
          ),
        ],
      ),
      Product(
        id: '5',
        name: 'Rose Gold Pendant',
        description: 'Elegant rose gold pendant with intricate design. Comes with matching chain. Perfect gift for loved ones.',
        price: 249.99,
        images: [
          'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?w=800',
        ],
        category: 'Necklaces',
        rating: 4.6,
        reviewCount: 142,
        isInStock: true,
        reviews: [],
      ),
      Product(
        id: '6',
        name: 'Crystal Stud Earrings',
        description: 'Sparkling crystal stud earrings that catch the light beautifully. Hypoallergenic and comfortable for all-day wear.',
        price: 89.99,
        images: [
          'https://images.unsplash.com/photo-1596944924616-7b38e7cfac36?w=800',
        ],
        category: 'Earrings',
        rating: 4.4,
        reviewCount: 87,
        isInStock: true,
        reviews: [],
      ),
    ];
  }
  
  static List<String> getCategories() {
    return ['All', 'Necklaces', 'Earrings', 'Bracelets', 'Rings'];
  }
  
  static User getCurrentUser() {
    return User(
      id: '1',
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      phone: '+1 234 567 8900',
      address: '123 Main Street, City, State 12345',
    );
  }
  
  static List<Order> getUserOrders() {
    return [
      Order(
        id: 'ORDER001',
        items: [
          CartItem(
            product: getProducts().first,
            quantity: 1,
          ),
        ],
        totalAmount: 299.99,
        orderDate: DateTime.now().subtract(Duration(days: 15)),
        status: 'Delivered',
        shippingAddress: '123 Main Street, City, State 12345',
      ),
      Order(
        id: 'ORDER002',
        items: [
          CartItem(
            product: getProducts()[1],
            quantity: 2,
          ),
        ],
        totalAmount: 299.98,
        orderDate: DateTime.now().subtract(Duration(days: 5)),
        status: 'Shipped',
        shippingAddress: '123 Main Street, City, State 12345',
      ),
    ];
  }
}