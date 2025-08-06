class SubscriptionModel {
  final String id;
  final String? name;
  final String? description;
  final String? amount;
  final String? recurring;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.recurring,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as String?,
      recurring: json['recurring'] as String?,
    );
  }
}
