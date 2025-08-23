const environment = {
  "USE_FIXTURES": bool.fromEnvironment('USE_FIXTURES'),
  "USE_SIMULATOR": bool.fromEnvironment('USE_SIMULATOR'),
  "ENVIRONMENT": String.fromEnvironment('ENVIRONMENT'),
  "TEST": bool.fromEnvironment('TEST'),
  "MODE": String.fromEnvironment('MODE'),

  "SIGNATURE_SECRET_KEY": String.fromEnvironment('SIGNATURE_SECRET_KEY'),

  "API_URL": String.fromEnvironment('API_URL'),

  "BUGSNAG_ENV": String.fromEnvironment('BUGSNAG_ENV'),
  "BUGSNAG_API_KEY": String.fromEnvironment('BUGSNAG_API_KEY'),

  "FIREBASE_MESSAGING_SENDER_ID": String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
  "FIREBASE_MESSAGING_PROJECT_ID": String.fromEnvironment('FIREBASE_MESSAGING_PROJECT_ID'),

  "FIREBASE_MESSAGING_API_KEY": String.fromEnvironment('FIREBASE_MESSAGING_API_KEY'),
  "FIREBASE_MESSAGING_APP_ID": String.fromEnvironment('FIREBASE_MESSAGING_APP_ID'),

  "FIREBASE_MESSAGING_IOS_API_KEY": String.fromEnvironment('FIREBASE_MESSAGING_IOS_API_KEY'),
  "FIREBASE_MESSAGING_GOOGLE_APP_ID": String.fromEnvironment('FIREBASE_MESSAGING_GOOGLE_APP_ID'),

  "STRIPE_PUBLIC_KEY": String.fromEnvironment('STRIPE_PUBLIC_KEY'),

  "GOOGLE_SIGN_IN_CLIENT_ID_IOS": String.fromEnvironment('GOOGLE_SIGN_IN_CLIENT_ID_IOS'),
  "GOOGLE_SIGN_IN_CLIENT_ID_ANDROID": String.fromEnvironment('GOOGLE_SIGN_IN_CLIENT_ID_ANDROID'),
  "GOOGLE_SIGN_IN_SERVER_ID": String.fromEnvironment('GOOGLE_SIGN_IN_SERVER_ID'),
};

final useFixtures = environment["USE_FIXTURES"];
final useSimulator = environment["USE_SIMULATOR"] as bool;
final isInTestEnv = environment["TEST"] == true;
final isInLocalEnv = environment["ENVIRONMENT"] == "local";
final isInDevEnv = environment["ENVIRONMENT"] == "development";
final isInProdEnv = environment["ENVIRONMENT"] == "production";
final isInFixturesMode = environment["MODE"] == "fixture";
final String signatureSecretKey = environment["SIGNATURE_SECRET_KEY"] as String;
final String googleAIUrl = environment["GOOGLE_AI_URL"] as String;
final String bugsnagEnvironment = environment["BUGSNAG_ENV"] as String;
final String bugsnagApiKey = environment["BUGSNAG_API_KEY"] as String;
final String googleSignInClientIdIos = environment["GOOGLE_SIGN_IN_CLIENT_ID_IOS"] as String;
final String googleSignInClientIdAndroid = environment["GOOGLE_SIGN_IN_CLIENT_ID_ANDROID"] as String;
final String googleSignInServerId = environment["GOOGLE_SIGN_IN_SERVER_ID"] as String;
// ignore: non_constant_identifier_names
final String API_URL = environment["API_URL"] as String;
final String STRIPE_PUBLIC_KEY = environment["STRIPE_PUBLIC_KEY"] as String;
