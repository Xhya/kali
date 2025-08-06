class CreateSubscriptionModel {
  final String customerEphemeralKeySecret;
  final String customerId;

  CreateSubscriptionModel({
    required this.customerEphemeralKeySecret,
    required this.customerId,
  });

  factory CreateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionModel(
      customerEphemeralKeySecret: json['ephemeralKeySecret'] as String,
      customerId: json['customerId'] as String,
    );
  }
}
