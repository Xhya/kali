import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/models/EditUser.formdata.dart';
import 'package:kali/core/models/User.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class UserRepository {
  Future<User?> refreshUser() async {
    final response = await http.get(
      Uri.parse('$API_URL/users'),
      headers: await headersWithoutToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(body['data']);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<User> saveProfile(EditUserFormData formData) async {
    Map body = {
      "username": formData.userName,
      "email": formData.email,
      "leitmotiv": formData.leitmotiv,
      "calories": formData.calories,
      "proteins": formData.proteins,
      "glucids": formData.glucids,
      "lipids": formData.lipids,
    };

    final response = await http.patch(
      Uri.parse('$API_URL/users'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(body['data']);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    Map body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse('$API_URL/users/register'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<bool> canCompute() async {
    final response = await http.get(
      Uri.parse('$API_URL/users/can-compute'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['data'];
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
