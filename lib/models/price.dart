class Price {
  final String currency;
  final int amount;

  Price({
    required this.currency,
    required this.amount,
  });

  @override
  String toString() {
    return "\u{20AC} ${amount / 100}";
  }

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currency: json['currency'],
      amount: json['amount'],
    );
  }
}
