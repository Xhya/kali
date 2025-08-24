class SubscriptionModel {
  final String id;
  final String? name;
  final String? description;
  final String? amount;
  final String? recurring;
  final String? amountText;
  final String? subamountText;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.recurring,
    required this.amountText,
    required this.subamountText,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as String?,
      recurring: json['recurring'] as String?,
      amountText: json['amountText'] as String?,
      subamountText: json['subamountText'] as String?,
    );
  }
}
