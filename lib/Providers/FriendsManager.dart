import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Friend? fetchFriendWithDocId(String docId) {
    return friendsMap[docId];
  }

  Future<void> setFriends(String uid) async {
    try {
      Map<String, Friend> temp = {};

      final String api = constants().fetchApi + 'users/${uid}.json';

      final response = await http.get(Uri.parse(api));
      
      if (json.decode(response.body) == null) {
        friendsMap = temp;
        notifyListeners();
        return;
      }
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      
      if (data.length != 0) {
        data.forEach((key, value) {
          temp[key] = Friend(
            isBestFriend: value['isBestFriend'],
            isCloseFriend: value['isCloseFriend'],
            title: value['title'],
            docId: key,
            dp: value['dp'],
            dob: value['dob'],
            about: value['about'],
            contactNumber: value['contactNumber'],
            education: value['education'],
            facebook: value['facebook'],
            gender: value['gender'],
            instagram: value['instagram'],
            interests: value['interests'] == null ? [] : value['interests'],
            linkedin: value['linkedin'],
            mail: value['mail'],
            college: value['college'],
            school: value['school'],
            work: value['work'],
            profession: value['profession'],
            snapchat: value['snapchat'],
            twitter: value['twitter'],
            youtube: value['youtube'],
          );
        });
      }

      friendsMap = temp;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateImageList(String uid, String docId, File? newImage) async {
    print('this is doc id' + docId);
    try {
      Random rd = Random();
      int num = rd.nextInt(100001);
      int num2 = rd.nextInt(51);
      int num3 = rd.nextInt(20001);
      String title = num.toString() + num2.toString() + num3.toString();
      final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
      String imageLocation = 'users/${uid}/${docId}/${title}';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(newImage!);
      final TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then((value) {
        print(docId);
        FirebaseFirestore.instance
            .collection(uid)
            .doc(docId)
            .collection('images')
            .add({'url': value});
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteFriend(String uid, String docId) async {
    try {
      final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
      http.delete(Uri.parse(api)).then((value) {
        friendsMap.remove(docId);
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> editFriendDetail(
      File? image, String uid, String docId, Friend friend) async {
    if (image != null) {
      try {
        String imageLocation = 'users/${uid}/${docId}/dp';
        final Reference storageReference =
            FirebaseStorage.instance.ref().child(imageLocation);
        final UploadTask uploadTask = storageReference.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask;
        taskSnapshot.ref.getDownloadURL().then((value) {
          final String api =
              constants().fetchApi + 'users/${uid}/${docId}.json';
          http.patch(Uri.parse(api),
              body: jsonEncode({
                'college': friend.college,
                'school': friend.school,
                'work': friend.work,
                'isBestFriend': friend.isBestFriend,
                'isCloseFriend': friend.isCloseFriend,
                'title': friend.title,
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
                'dp': value,
                'contactNumber': friend.contactNumber,
                'docId': '',
                'mail': friend.mail,
                'linkedin': friend.linkedin,
              }));
        });
      } catch (error) {
        print(error);
      }
    } else {
      print('entry here');
      print(friend.dp);
      try {
        final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
        http.patch(Uri.parse(api),
            body: jsonEncode({
              'college': friend.college,
              'school': friend.school,
              'work': friend.work,
              'isBestFriend': friend.isBestFriend,
              'isCloseFriend': friend.isCloseFriend,
              'title': friend.title,
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
              'dp': friend.dp,
              'contactNumber': friend.contactNumber,
              'docId': '',
              'mail': friend.mail,
              'linkedin': friend.linkedin,
            }));
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> updateCloseFriend(
    String? uid,
    String? docId,
  ) async {
    try {
      bool? isCurrentlyCloseFriend = friendsMap[docId]!.isCloseFriend;
      final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
      http
          .patch(Uri.parse(api),
              body: json.encode({
                'isCloseFriend': !isCurrentlyCloseFriend!,
              }))
          .then((value) {
        Friend updateFriend = Friend(
            about: friendsMap[docId]!.about,
            college: friendsMap[docId]!.college,
            contactNumber: friendsMap[docId]!.contactNumber,
            dob: friendsMap[docId]!.dob,
            docId: friendsMap[docId]!.docId,
            dp: friendsMap[docId]!.dp,
            education: friendsMap[docId]!.education,
            facebook: friendsMap[docId]!.facebook,
            gender: friendsMap[docId]!.gender,
            instagram: friendsMap[docId]!.instagram,
            interests: friendsMap[docId]!.interests,
            isBestFriend: friendsMap[docId]!.isBestFriend,
            isCloseFriend: !isCurrentlyCloseFriend,
            linkedin: friendsMap[docId]!.linkedin,
            mail: friendsMap[docId]!.mail,
            profession: friendsMap[docId]!.profession,
            school: friendsMap[docId]!.school,
            snapchat: friendsMap[docId]!.snapchat,
            title: friendsMap[docId]!.title,
            twitter: friendsMap[docId]!.twitter,
            work: friendsMap[docId]!.work,
            youtube: friendsMap[docId]!.youtube);
        friendsMap[docId!] = updateFriend;
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateBestFriend(
    String? uid,
    String? docId,
  ) async {
    try {
      bool? isCurrentlyBestFriend = friendsMap[docId]!.isBestFriend;
      final String api = constants().fetchApi + 'users/${uid}/${docId}.json';
      http
          .patch(Uri.parse(api),
              body: json.encode({
                'isBestFriend': !isCurrentlyBestFriend!,
              }))
          .then((value) {
        Friend updateFriend = Friend(
            about: friendsMap[docId]!.about,
            college: friendsMap[docId]!.college,
            contactNumber: friendsMap[docId]!.contactNumber,
            dob: friendsMap[docId]!.dob,
            docId: friendsMap[docId]!.docId,
            dp: friendsMap[docId]!.dp,
            education: friendsMap[docId]!.education,
            facebook: friendsMap[docId]!.facebook,
            gender: friendsMap[docId]!.gender,
            instagram: friendsMap[docId]!.instagram,
            interests: friendsMap[docId]!.interests,
            isBestFriend: !isCurrentlyBestFriend,
            isCloseFriend: friendsMap[docId]!.isCloseFriend,
            linkedin: friendsMap[docId]!.linkedin,
            mail: friendsMap[docId]!.mail,
            profession: friendsMap[docId]!.profession,
            school: friendsMap[docId]!.school,
            snapchat: friendsMap[docId]!.snapchat,
            title: friendsMap[docId]!.title,
            twitter: friendsMap[docId]!.twitter,
            work: friendsMap[docId]!.work,
            youtube: friendsMap[docId]!.youtube);
        friendsMap[docId!] = updateFriend;
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addFriend(String uid, File? image, Friend friend) async {
    if (image == null) {
      try {
        final String api = constants().fetchApi + 'users/${uid}.json';
        return http
            .post(Uri.parse(api),
                body: json.encode({
                  'college': friend.college,
                  'school': friend.school,
                  'work': friend.work,
                  'isBestFriend': friend.isBestFriend,
                  'isCloseFriend': friend.isCloseFriend,
                  'title': friend.title,
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
            .then((value) {
          var data = jsonDecode(value.body) as Map<String, dynamic>;
          print(data['name'] + 'key id');
          friendsMap[data['name']] = friend;
          notifyListeners();
        });
      } catch (error) {
        print(error);
      }
    } else {
      try {
        final String api = constants().fetchApi + 'users/${uid}.json';
        return http
            .post(Uri.parse(api),
                body: json.encode({
                  'college': friend.college,
                  'school': friend.school,
                  'work': friend.work,
                  'isBestFriend': friend.isBestFriend,
                  'isCloseFriend': friend.isCloseFriend,
                  'title': friend.title,
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
          final UploadTask uploadTask = storageReference.putFile(image);
          final TaskSnapshot taskSnapshot = await uploadTask;
          taskSnapshot.ref.getDownloadURL().then((value) {
            http.patch(Uri.parse(api2),
                body: json.encode({
                  'docId': docId,
                  'dp': value,
                }));
          });
          friendsMap[docId!] = friend;
          notifyListeners();
        });
      } catch (error) {
        print(error);
      }
    }
  }
}
