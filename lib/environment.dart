const environment = {
  "USE_FIXTURES": bool.fromEnvironment('USE_FIXTURES'),
  "USE_SIMULATOR": bool.fromEnvironment('USE_SIMULATOR'),
  "ENVIRONMENT": String.fromEnvironment('ENVIRONMENT'),
  "TEST": bool.fromEnvironment('TEST'),
  "MODE": String.fromEnvironment('MODE'),
  "GOOGLE_AI_API_KEY": String.fromEnvironment('GOOGLE_AI_API_KEY'),
  "GOOGLE_AI_URL": String.fromEnvironment('GOOGLE_AI_URL'),
  "BUGSNAG_ENV": String.fromEnvironment('BUGSNAG_ENV'),
  "BUGSNAG_API_KEY": String.fromEnvironment('BUGSNAG_API_KEY'),
};

final useFixtures = environment["USE_FIXTURES"];
final useSimulator = environment["USE_SIMULATOR"];
final isInTestEnv = environment["TEST"] == true;
final isInLocalEnv = environment["ENVIRONMENT"] == "local";
final isInDevEnv = environment["ENVIRONMENT"] == "development";
final isInProdEnv = environment["ENVIRONMENT"] == "production";
final isInFixturesMode = environment["MODE"] == "fixture";
final String googleAIUrl = environment["GOOGLE_AI_URL"] as String;
final String bugsnagEnvironment = environment["BUGSNAG_ENV"] as String;
final String bugsnagApiKey = environment["BUGSNAG_API_KEY"] as String;

