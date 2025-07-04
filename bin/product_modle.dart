class ProductModel {
  final String name;
  final double price;
  final int quantity;
  final Expirable? expirable;
  final Shippable? shippable;
  ProductModel({
    required this.name,
    required this.price,
    required this.quantity,
    this.expirable,
    this.shippable,
  });

  bool isExpired() => expirable?.isExpired() ?? false;
  bool isShippable() => shippable != null;
  double getWeight() => shippable?.weight ?? 0.0;
  bool hasStock() => quantity > 0;
}

class Expirable {
  final DateTime expireDate;
  Expirable({required this.expireDate});

  bool isExpired() => DateTime.now().isAfter(expireDate);
}

class Shippable {
  final double weight;
  Shippable({required this.weight});
}
