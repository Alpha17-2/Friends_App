import 'dart:convert';
import 'dart:io';

import 'package:firstapp/Helpers/constants.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsManager extends ChangeNotifier{
  // String denotes ID ,
  Map<String,Friend> friendsMap = {};

  List<Friend> get list {
    return friendsMap.values.toList();
  }

  Future<void> setFriends()async{
    try{
      Map<String,Friend> temp = {};
      final String api = constants().fetchApi + 'friends.json';
      final response = await http.get(Uri.parse(api));
      final data = json.decode(response.body) as Map<String,dynamic>;
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
    }
    catch(error){
      print(error);
    }
  }

  Future<void> addFriend(File image,Friend friend) async{

  }


}