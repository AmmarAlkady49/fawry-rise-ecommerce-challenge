import 'cart_item.dart';
import '../bin/customer.dart';
import '../bin/shipping_service.dart';

class Cart {
  final List<CartItem> _items = [];
  static const double shipmentCostPerKiloGram = 10.0;

  List<CartItem> get items => _items;

  bool get isEmpty => _items.isEmpty;

  void addItem(CartItem item) {
    if (item.quantity > 0 &&
        item.quantity <= item.product.quantity &&
        !item.product.isExpired()) {
      _items.add(item);
    } else {
      throw Exception('Item is out of stock or expired.');
    }
  }

  void removeItem(CartItem item) {
    if (item.quantity > 0) {
      _items.removeWhere(
          (cartItem) => cartItem.product.name == item.product.name);
    } else {
      print('Item quantity is invalid.');
    }
  }

  void clear() => _items.clear();

  double getSubtotal() {
    return _items.fold(0.0, (total, item) => total + item.totalPrice);
  }

  List<CartItem> getShippableItems() {
    return _items.where((item) => item.product.isShippable()).toList();
  }

  double calculateShippingFees() {
    final shippableItems = getShippableItems();
    double totalWeight = 0.0;

    for (var item in shippableItems) {
      totalWeight += item.product.getWeight() * item.quantity;
    }

    return totalWeight * shipmentCostPerKiloGram;
  }

  void checkout(Customer customer, ShippingService shippingService) {
    // 1- Check if cart is empty
    if (isEmpty) {
      throw Exception('Cart is empty');
    }

    // 2- Re-check stock and expiration at checkout
    for (var item in _items) {
      if (item.quantity > item.product.quantity) {
        throw Exception('Product ${item.product.name} is out of stock');
      }
      if (item.product.isExpired()) {
        throw Exception('Product ${item.product.name} is expired');
      }
    }

    // Calculate totals
    double subtotal = getSubtotal();
    double shippingFees = calculateShippingFees();
    double totalAmount = subtotal + shippingFees;

    // 3- Check customer balance
    if (!customer.hasEnoughBalance(totalAmount)) {
      throw Exception(
          'Customer balance is insufficient. Required: ${totalAmount}EGP, Available: ${customer.balance}EGP');
    }

    // Process payment
    customer.deductBalance(totalAmount);

    // Print checkout details
    _printCheckoutReceipt(
        subtotal, shippingFees, totalAmount, customer.balance);

    // Send shippable items to shipping service
    final shippableItems = getShippableItems();
    if (shippableItems.isNotEmpty) {
      final shippableCartItems =
          shippableItems.map((item) => ShippableCartItem(item)).toList();
      shippingService.shipItems(shippableCartItems);
    }

    // Clear cart after successful checkout
    clear();
  }

  void _printCheckoutReceipt(double subtotal, double shippingFees,
      double totalAmount, double remainingBalance) {
    print("\n=== CHECKOUT RECEIPT ===");

    // Print items
    for (var item in _items) {
      print("${item.quantity}x ${item.product.name} - ${item.totalPrice}EGP");
    }

    print("------------------------");
    print("Order subtotal: ${subtotal}EGP");
    print("Shipping fees: ${shippingFees}EGP");
    print("------------------------");
    print("Paid amount: ${totalAmount}EGP");
    print("Customer current balance after payment: ${remainingBalance}EGP");
    print("========================\n");
  }
}
