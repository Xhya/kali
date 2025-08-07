class CreateSubscriptionModel {
  final String customerEphemeralKeySecret;
  final String customerId;
  final String setupIntentClientSecret;

  CreateSubscriptionModel({
    required this.customerEphemeralKeySecret,
    required this.customerId,
    required this.setupIntentClientSecret,
  });

  factory CreateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionModel(
      customerEphemeralKeySecret: json['ephemeralKeySecret'] as String,
      customerId: json['customerId'] as String,
      setupIntentClientSecret: json['setupIntentClientSecret'] as String,
    );
  }
}
