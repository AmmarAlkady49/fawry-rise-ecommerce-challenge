import '../bin/product_modle.dart';
import '../bin/cart.dart';
import '../bin/cart_item.dart';
import '../bin/shipping_service.dart';
import '../bin/customer.dart';

void main(List<String> arguments) {
  final ProductModel cheese = ProductModel(
    name: "cheese",
    price: 100,
    quantity: 10,
    expirable: Expirable(expireDate: DateTime(2025, 12, 30)),
    shippable: Shippable(weight: 2),
  );
  final ProductModel expiredBread = ProductModel(
    name: "Bread",
    price: 5,
    quantity: 10,
    expirable: Expirable(expireDate: DateTime(2025, 6, 1)), // Expired
    shippable: Shippable(weight: 0.5),
  );

  final ProductModel tv = ProductModel(
    name: "tv",
    price: 2000,
    quantity: 5,
    shippable: Shippable(weight: 15),
  );

  final ProductModel scratchCard = ProductModel(
    name: "scratchCard",
    price: 10,
    quantity: 5,
  );
  final Customer customer = Customer(name: "Ammar Alkady", balance: 10000);
  final Cart cart = Cart();
  final ShippingService shippingService = ShippingServiceImpl();

  print("=== E-COMMERCE SYSTEM DEMO ===\n");

  print("--- Test Case 1: Successful Checkout ---");
  try {
    cart.addItem(CartItem(product: cheese, quantity: 2));
    cart.addItem(CartItem(product: tv, quantity: 3));
    cart.addItem(CartItem(product: scratchCard, quantity: 1));

    print("Customer balance before checkout: ${customer.balance}EGP");
    cart.checkout(customer, shippingService);
    print("Customer balance after checkout: ${customer.balance}EGP");
  } catch (e) {
    print(e);
  }

  print("\n--- Test Case 2: Empty Cart ---");
  try {
    cart.checkout(customer, shippingService);
  } catch (e) {
    print("Error: $e");
  }

  print("\n--- Test Case 3: Expired Product ---");
  try {
    cart.addItem(CartItem(product: expiredBread, quantity: 1));
  } catch (e) {
    print("Error: $e");
  }

  print("\n--- Test Case 4: Out of Stock ---");
  try {
    cart.addItem(CartItem(product: tv, quantity: 10)); // ** Only 5 available ** 
  } catch (e) {
    print("Error: $e");
  }

  // Test Case 5: Insufficient balance
  print("\n--- Test Case 5: Insufficient Balance ---");
  try {
    final poorCustomer = Customer(name: "Poor Customer", balance: 50);
    cart.addItem(CartItem(product: tv, quantity: 1));
    cart.checkout(poorCustomer, shippingService);
  } catch (e) {
    print("Error: $e");
  }
}