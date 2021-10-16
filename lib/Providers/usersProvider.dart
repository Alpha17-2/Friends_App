import 'dart:convert';

import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class usersProvider extends ChangeNotifier {
  Map<String, UserProfile> profilesUsingId = {};
  Map<String, UserProfile> profilesUsingDocId = {};

  Map<String, UserProfile> get fetchUsersUsingId {
    return profilesUsingId;
  }

  Map<String, UserProfile> get fetchUsersUsingDocId {
    return profilesUsingDocId;
  }

  UserProfile getUserUsingId(String id) {
    return profilesUsingId[id];
  }

  Future<void> setUsers() async {
    try {
      Map<String, UserProfile> tempId = {};
      Map<String, UserProfile> tempDocId = {};
      final String api = constants().fetchApi + 'users.json';
      final response = await http.get(Uri.parse(api));
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach((key, value) {
          tempDocId[key] = UserProfile(
            id: value['id'],
            title: value['title'],
          );
          tempId[value['id']] = UserProfile(
            id: value['id'],
            title: value['title'],
          );
        });
        profilesUsingDocId = tempDocId;
        profilesUsingId = tempId;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> createProfile(UserProfile profile) async {
    try {
      final String api = constants().fetchApi + 'users.json';
      return http
          .post(Uri.parse(api),
              body: json.encode({
                'title': profile.title,
                'id': profile.id,
              }))
          .then((value) {
        profilesUsingId[profile.id] = profile;
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }

  bool profileExist(String uid) {
    return profilesUsingId.containsKey(uid);
  }
}
