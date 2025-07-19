import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:kali/environment.dart';

class AuthenticationRepository {
  Future<void> initUser() async {
    final formattedSignature = await getFormattedSignature();

    Map body = {"formattedSignature": formattedSignature};

    final response = await http.post(
      Uri.parse('$API_URL/users/init'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
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
