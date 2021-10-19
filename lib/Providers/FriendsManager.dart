import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Models/friends.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsManager extends ChangeNotifier {
  // String denotes ID ,
  Map<String, Friend> friendsMap = {};

  List<Friend> get list {
    return friendsMap.values.toList();
  }

  Future<void> setFriends() async {
    try {
      Map<String, Friend> temp = {};
      final String api = constants().fetchApi + 'friends.json';
      final response = await http.get(Uri.parse(api));
      final data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, value) {
        temp[key] = Friend(
          title: value['title'],
          docId: value['docId'],
          dp: value['dp'],
          dob: value['dob'],
          about: value['about'],
          contactNumber: value['contactNumber'],
          education: value['eduction'],
          facebook: value['facebook'],
          gender: value['gender'],
          instagram: value['instagram'],
          interests: value['interests'],
          linkedin: value['linkedin'],
          mail: value['mail'],
          profession: value['profession'],
          snapchat: value['snapchat'],
          twitter: value['twitter'],
          youtube: value['youtube'],
        );
      });
      friendsMap = temp;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addFriend(File image, Friend friend) async {
    try {
      final String api = constants().fetchApi + 'friends.json';
      return http
          .post(Uri.parse(api),
              body: json.encode({
                'title': friend.title,
                'dob': friend.dob,
                'education': friend.education,
                'gender': friend.gender,
                'about': friend.gender,
                'profession': friend.profession,
                'interests': friend.interests,
                'instagram': friend.instagram,
                'twitter': friend.twitter,
                'youtube': friend.youtube,
                'snapchat': friend.snapchat,
                'facebook': friend.facebook,
                'dp': '',
                'contactNumber': friend.contactNumber,
                'docId': '',
                'mail': friend.mail,
                'linkedin': friend.linkedin,
              }))
          .then((value) async {
        final data = json.decode(value.body) as Map<String, dynamic>;
        String docId = data['name'];
        final api2 = constants().fetchApi + 'friends/${docId}.json';
        String imageLocation = 'friends/${docId}/dp';
        final Reference storageReference =
        FirebaseStorage.instance.ref().child(imageLocation);
        final UploadTask uploadTask = storageReference.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask;
        taskSnapshot.ref.getDownloadURL().then((value) {
          http.patch(Uri.parse(api2), body: json.encode(
              {
                'docId' : docId,
                'dp' : value,
              }
          ));
        });
      });
    } catch (error) {
      print(error);
    }
  }
}
