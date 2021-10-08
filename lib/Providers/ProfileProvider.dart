import 'dart:convert';

import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  List<Profile> listOfProfiles = [];

  Future<void> addProfile(Profile newProfile) async {
    final apiUrl = constants().fetchApi+'.json';
    try {
      return http
          .post(Uri.parse(apiUrl),
              body: json.encode({
                'name': newProfile.name,
                'id': '',
                'sex': newProfile.sex,
                'edu': newProfile.edu,
                'phone_number': newProfile.phone_number
              }))
          .then((value) {
            listOfProfiles.add(newProfile);
            notifyListeners();
          });
    } catch (error) {
      print(error);
    }
  }

  void deleteProfile(Profile profile) {
    int indexToDelete =
        listOfProfiles.indexWhere((element) => element.id == profile.id);
    if (indexToDelete != -1) {
      listOfProfiles.removeAt(indexToDelete);
    }
    notifyListeners();
  }

  List<Profile> get fetchListOfProfiles {
    return [...listOfProfiles];
  }
}
