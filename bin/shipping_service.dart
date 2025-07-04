
import 'cart_item.dart';

abstract class ShippableItem {
  String getName();
  double getWeight();
}

abstract class ShippingService {
  void shipItems(List<ShippableItem> items);
}

class ShippingServiceImpl implements ShippingService {
  @override
  void shipItems(List<ShippableItem> items) {
    print("\n=== SHIPPING NOTIFICATION ===");
    for (var item in items) {
      print("Shipping: ${item.getName()} - Weight: ${item.getWeight()}kg");
    }
    print("Items have been sent for shipping.\n");
  }
}


class ShippableCartItem implements ShippableItem {
  final CartItem cartItem;
  
  ShippableCartItem(this.cartItem);
  
  @override
  String getName() => "${cartItem.quantity}x ${cartItem.product.name}";
  
  @override
  double getWeight() => cartItem.product.getWeight() * cartItem.quantity;
}