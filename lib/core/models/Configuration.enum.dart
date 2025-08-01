enum ConfigKeyEnum {
  forceUpdateVersion('force_update_version'),
  usedTokensWithoutEmailText('used_tokens_without_email_text'),
  usedTokensWithoutPaymentText('used_tokens_without_payment_text');

  const ConfigKeyEnum(this.label);
  final String label;

  factory ConfigKeyEnum.fromText(String text) {
    return ConfigKeyEnum.values.firstWhere((it) => it.label == text);
  }
}
