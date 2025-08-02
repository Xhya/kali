import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Configuration.enum.dart';
import 'package:kali/core/models/configuration.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class ConfigurationsRepository {
  Future<List<ConfigurationModel>> getInit() async {
    final response = await http.get(
      Uri.parse('$API_URL/configurations/init'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final raw = body['data'];
      return raw
          .map<ConfigurationModel>((e) => ConfigurationModel.fromJson(e))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<String> getConfig(ConfigKeyEnum configKey) async {
    final response = await http.get(
      Uri.parse('$API_URL/configurations/${configKey.label}'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body["data"];
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
