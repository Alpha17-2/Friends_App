import 'dart:convert';

import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class usersProvider extends ChangeNotifier {
  Map<String, userProfile> profilesUsingId = {};
  Map<String, userProfile> profilesUsingDocId = {};

  Map<String, userProfile> get fetchUsersUsingId {
    return profilesUsingId;
  }

  Map<String, userProfile> get fetchUsersUsingDocId {
    return profilesUsingDocId;
  }

  Future<void> setUsers() async {
    try {
      Map<String, userProfile> tempId = {};
      Map<String, userProfile> tempDocId = {};
      final String api = constants().fetchApi + 'users.json';
      final response = await http.get(Uri.parse(api));
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach((key, value) {
          tempDocId[key] = userProfile(
            docId: key,
            dp: value['dp'],
            education: value['education'],
            email: value['email'],
            id: value['id'],
            title: value['title'],
          );
          tempId[value['id']] = userProfile(
            docId: key,
            dp: value['dp'],
            education: value['education'],
            email: value['email'],
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
}
