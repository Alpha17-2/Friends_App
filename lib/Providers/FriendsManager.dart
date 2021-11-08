import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsManager extends ChangeNotifier {
  // String denotes ID ,
  Map<String, Friend> friendsMap = {};

  List<Friend> get fetchList {
    return friendsMap.values.toList();
  }

  Future<void> setFriends(String uid) async {
    try {
      Map<String, Friend> temp = {};
      final String api = constants().fetchApi + 'users/${uid}.json';
      final response = await http.get(Uri.parse(api));
      print(response.statusCode);
      final Map<String,dynamic> data = json.decode(response.body) as Map<String, dynamic>;
      if(data.length!=0){
        print('enter');
        data.forEach((key, value) {
          temp[key] = Friend(
            isBestFriend: value['isBestFriend'],
            isCloseFriend: value['isCloseFriend'],
            title: value['title'],
            docId: value['docId'],
            dp: value['dp'],
            dob: value['dob'],
            about: value['about'],
            contactNumber: value['contactNumber'],
            education: value['education'],
            facebook: value['facebook'],
            gender: value['gender'],
            instagram: value['instagram'],
            interests: value['interests'],
            linkedin: value['linkedin'],
            mail: value['mail'],
            images: value['images'],
            profession: value['profession'],
            snapchat: value['snapchat'],
            twitter: value['twitter'],
            youtube: value['youtube'],
          );
        });
      }
      print('exit');
      friendsMap = temp;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateImageList(String uid,String docId) async {
    try {
      final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
      http.patch(Uri.parse(api),body: json.encode({
        'listOfImages' : [],
      }));
    } catch (error) {
      print(error);
    }
  }
  Future<void> addFriend(String uid,File? image, Friend friend) async {
    try {
      final String api = constants().fetchApi + 'users/${uid}.json';
      return http
          .post(Uri.parse(api),
          body: json.encode({
            'isBestFriend' : friend.isBestFriend,
            'isCloseFriend' : friend.isCloseFriend,
            'title': friend.title,
            'images' : ['hello'],
            'dob': friend.dob,
            'education': friend.education,
            'gender': friend.gender,
            'about': friend.about,
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
        String? docId = data['name'];
        final api2 = constants().fetchApi + 'users/${uid}/${docId}.json';
        String imageLocation = 'users/${uid}/${docId}/dp';
        final Reference storageReference =
        FirebaseStorage.instance.ref().child(imageLocation);
        final UploadTask uploadTask = storageReference.putFile(image!);
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


