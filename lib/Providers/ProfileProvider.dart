import 'package:firstapp/Models/Profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  List<Profile> listOfProfiles = [];

  void addProfile(Profile newProfile) {
    listOfProfiles.add(newProfile);
    notifyListeners();
  }

  List<Profile> get fetchListOfProfiles {
    return [...listOfProfiles];
  }
}
