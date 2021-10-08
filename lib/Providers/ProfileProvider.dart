import 'package:firstapp/Models/Profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  List<Profile> listOfProfiles = [];

  void addProfile(Profile newProfile) {
    listOfProfiles.add(newProfile);
    notifyListeners();
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
