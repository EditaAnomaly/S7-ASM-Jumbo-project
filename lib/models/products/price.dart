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

  String getInteger() {
    return (amount / 100).floor().toString();
  }

  String getFractional() {
    String s = (amount / 100).toStringAsFixed(2);
    return s.split(".")[1];
  }
}
