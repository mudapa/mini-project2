import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project_team_7/data/model/profile_model.dart';
import 'package:mini_project_team_7/data/remote/api_path.dart';
import 'package:mini_project_team_7/data/remote/profile_remote.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Remote Test :', () {
    final client = MockClient();
    final profileRemote = ProfileRemote();
    test('Fetch Profile', () async {
      when(client.get(Uri.parse('${ApiPath.baseUrl}/users/1'))).thenAnswer(
        (_) async => http.Response(
            '{"address": {"geolocation": {"lat": "-37.3159","long": "81.1496"}, "city": "kilcoole", "street": "new road", "number": 7682, "zipcode": "12926-3874"}, "id": 1, "email": "john@gmail.com", "username": "johnd", "password": "m38rmF\$", "name": {"firstname": "john","lastname": "doe"}, "phone": "1-570-236-7033", "__v": 0}',
            200),
      );
      expect(await profileRemote.fetchProfile(client), isA<ProfileModel>());
    });
  });
}
