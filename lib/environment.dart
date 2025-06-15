const environment = {
  "USE_FIXTURES": bool.fromEnvironment('USE_FIXTURES'),
  "ENVIRONMENT": String.fromEnvironment('ENVIRONMENT'),
  "TEST": bool.fromEnvironment('TEST'),
  "GOOGLE_AI_API_KEY": String.fromEnvironment('GOOGLE_AI_API_KEY'),
  "GOOGLE_AI_URL": String.fromEnvironment('GOOGLE_AI_URL'),
};

final useFixtures = environment["USE_FIXTURES"];
final isInTestEnv = environment["TEST"] == true;
final String googleAIUrl = environment["GOOGLE_AI_URL"] as String;
