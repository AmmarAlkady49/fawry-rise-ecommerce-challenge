class Customer {
  final String name;
  double balance;
  
  Customer({required this.name, required this.balance});
  
  bool hasEnoughBalance(double amount) => balance >= amount;
  
  void deductBalance(double amount) {
    if (hasEnoughBalance(amount)) {
      balance -= amount;
    } else {
      throw Exception('Insufficient balance');
    }
  }
}