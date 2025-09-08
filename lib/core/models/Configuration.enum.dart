enum ConfigKeyEnum {
  forceUpdateVersion('force_update_version'),
  computeMaxCharactersCount('compute_max_characters_count'),
  activateSubscription('activate_subscription'),
  lastVersion('last_version');

  const ConfigKeyEnum(this.label);
  final String label;

  factory ConfigKeyEnum.fromText(String text) {
    return ConfigKeyEnum.values.firstWhere((it) => it.label == text);
  }
}
