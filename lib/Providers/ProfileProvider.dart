import 'dart:convert';

import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  List<Profile> listOfProfiles = [];

  Future<void> addProfile(Profile newProfile) async {
    final apiUrl = constants().fetchApi + '.json';
    try {
      return http
          .post(Uri.parse(apiUrl),
              body: json.encode({
                'age': newProfile.age,
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

  Future<void> fetchAndSetData() async {
    final apiUrl = constants().fetchApi + '.json';
    List<Profile> temp = [];
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode < 400) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data == null) {
          listOfProfiles = temp;
          notifyListeners();
          return;
        }
        data.forEach((key, value) {
          temp.add(Profile(
            age: value['age'],
            edu: value['edu'],
            id: key,
            name: value['name'],
            phone_number: value['phone_number'],
            sex: value['sex'],
          ));
        });
        listOfProfiles = temp;
        notifyListeners();
      } else {
        print('Something is wrong');
      }
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
