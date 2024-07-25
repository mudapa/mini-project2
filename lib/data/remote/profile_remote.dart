import 'package:mini_project_team_7/data/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_path.dart';

class ProfileRemote {
  Future<ProfileModel> fetchProfile(
    http.Client? client,
  ) async {
    final response = await client!.get(Uri.parse("${ApiPath.baseUrl}/users/1"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ProfileModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
