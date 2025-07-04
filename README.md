# 🛒 E-commerce System

**Fawry Rise Journey - Full Stack Development Internship Challenge**

A simple e-commerce system built with Dart that handles products, shopping cart, and checkout.

## 🚀 Features

* 📦 **Products**: Create products with name, price, and quantity
* ⏰ **Expirable Products**: Some products expire (Cheese, Biscuits)
* 🚚 **Shippable Products**: Some products need shipping with weight
* 🛍️ **Shopping Cart**: Add products with quantity validation
* 💳 **Checkout**: Calculate totals and process payments
* ❌ **Error Handling**: Handle empty cart, insufficient balance, expired products

## 🏗️ How It Works

### Product Types

```dart
// Expirable + Shippable (Cheese)
final cheese = ProductModel(
  name: "cheese",
  price: 100,
  quantity: 10,
  expirable: Expirable(expireDate: DateTime(2025, 12, 30)),
  shippable: Shippable(weight: 2),
);

// Only Shippable (TV)
final tv = ProductModel(
  name: "tv",
  price: 2000,
  quantity: 5,
  shippable: Shippable(weight: 15),
);

// No special features (Scratch Card)
final scratchCard = ProductModel(
  name: "scratchCard",
  price: 10,
  quantity: 5,
);
```

### Shopping Cart Usage

```dart
final customer = Customer(name: "Ammar", balance: 10000);
final cart = Cart();

// Add items
cart.addItem(CartItem(product: cheese, quantity: 2));
cart.addItem(CartItem(product: tv, quantity: 1));
cart.addItem(CartItem(product: scratchCard, quantity: 1));

// Checkout
cart.checkout(customer, shippingService);
```

## 📋 Sample Output

```
=== CHECKOUT RECEIPT ===
2x cheese - 200.0EGP
3x tv - 6000.0EGP
1x scratchCard - 10.0EGP
------------------------
Order subtotal: 6210.0EGP
Shipping fees: 490.0EGP
------------------------
Paid amount: 6700.0EGP
Customer current balance after payment: 3300.0EGP
========================

=== SHIPPING NOTIFICATION ===
Shipping: 2x cheese - Weight: 4.0kg
Shipping: 3x tv - Weight: 45.0kg
Items have been sent for shipping.
```

## 🛠️ Project Structure

```
lib/
├── bin/
│   ├── main.dart              # 🎯 Main application
│   ├── product_modle.dart     # 📦 Product classes
│   ├── customer.dart          # 👤 Customer management
│   ├── cart.dart              # 🛒 Shopping cart logic
│   ├── cart_item.dart         # 📋 Cart item
│   └── shipping_service.dart  # 🚚 Shipping service
```

## ⚡ Quick Start

1. **Install Dart SDK**
2. **Clone the repository**
3. **Run the application**:

```bash
dart run bin/main.dart
```

## 🧪 Test Cases

The system includes 5 test cases:

* ✅ **Successful Checkout** - Normal purchase flow
* ❌ **Empty Cart** - Error when cart is empty
* ❌ **Expired Product** - Cannot add expired products
* ❌ **Out of Stock** - Cannot exceed available quantity
* ❌ **Insufficient Balance** - Customer needs enough money

## 🎯 Key Design Decisions

* **Composition over Inheritance**: Products can be expirable, shippable, both, or neither
* **Interface Segregation**: ShippingService only needs `getName()` and `getWeight()`
* **Error Handling**: Clear exceptions for all edge cases
* **Immutable Design**: Products and cart items are immutable

## 📝 Requirements Covered

* ✅ Products with name, price, quantity
* ✅ Expirable products (Cheese, Biscuits)
* ✅ Shippable products with weight
* ✅ Cart with quantity validation
* ✅ Checkout with subtotal, shipping, total
* ✅ Customer balance management
* ✅ Error handling for all cases
* ✅ ShippingService integration

---

**Made with ❤️ for Fawry Rise Journey Internship Challenge**