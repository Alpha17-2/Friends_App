import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Helpers/custom_paint.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Helpers/widgets.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:firstapp/Providers/categoryManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class myFriendsScreen extends StatefulWidget {
  @override
  State<myFriendsScreen> createState() => _myFriendsScreenState();
}

class _myFriendsScreenState extends State<myFriendsScreen> {
  User? currentUser;
  bool init = true;
  bool isLoading = true;
  final unselectedCategory = [Colors.black54, Colors.black54];

  @override
  void didChangeDependencies() async {
    if (init) {
      Provider.of<FriendsManager>(context).setFriends(currentUser!.uid.toString()).then((value) {
        isLoading = false;
      });
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Friend> friends = Provider.of<FriendsManager>(context).fetchList;
    int currentCategory =
        Provider.of<categoryManager>(context).fetchCurrentCategory;
    searchBox() {
      return TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Search friend',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.orange[600],
            )),
      );
    }

    

    return Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Positioned(
              child: CustomPaint(
                child: Container(
                  height: displayHeight(context) * 0.13,
                  width: displayWidth(context),
                ),
                painter: CurvePainter(),
              ),
              top: 0,
            ),
            Positioned(
              top: displayHeight(context) * 0.05,
              child: CircleAvatar(
                radius: displayWidth(context) * 0.115,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: displayWidth(context) * 0.1,
                  backgroundImage: AssetImage('images/friendsIcon2.png'),
                ),
              ),
            ),
            Positioned(
                top: displayHeight(context) * 0.17,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      currentUser!.displayName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: displayWidth(context) * 0.04),
                    ),
                    Divider(
                      height: 1.5,
                    ),
                    Text(
                      '${friends.length.toString()} Friends',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: displayWidth(context) * 0.035),
                    ),
                  ],
                )),
            Positioned(
                top: displayHeight(context) * 0.235,
                child: Container(
                  height: displayHeight(context) * 0.14,
                  width: displayWidth(context),
                  //color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Container(
                          height: displayHeight(context) * 0.055,
                          width: displayWidth(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: Center(child: searchBox()),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Provider.of<categoryManager>(context,
                                        listen: false)
                                    .updateCategory(0);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                //color: Colors.orange[300],
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: (currentCategory == 0)
                                            ? [
                                                Colors.orange[300]!,
                                                Colors.orange[200]!
                                              ]
                                            : unselectedCategory,
                                      ),
                                      borderRadius: BorderRadius.circular(45)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, left: 16, right: 16, bottom: 6),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/all.png',
                                            height: displayHeight(context) * 0.028,
                                            fit: BoxFit.cover,
                                          ),
                                          VerticalDivider(
                                            width: displayWidth(context) * 0.02,
                                          ),
                                          Text(
                                            'ALL',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: displayWidth(context) *
                                                    0.03),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Best friends
                            InkWell(
                              onTap: () {
                                Provider.of<categoryManager>(context,
                                        listen: false)
                                    .updateCategory(1);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                //color: Colors.orange[300],
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: (currentCategory == 1)
                                            ? [
                                                Colors.orange[300]!,
                                                Colors.orange[200]!
                                              ]
                                            : unselectedCategory,
                                      ),
                                      borderRadius: BorderRadius.circular(45)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, left: 16, right: 16, bottom: 6),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/bff.png',
                                            height: displayHeight(context) * 0.028,
                                            fit: BoxFit.cover,
                                          ),
                                          VerticalDivider(
                                            width: displayWidth(context) * 0.02,
                                          ),
                                          Text(
                                            'BFF',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: displayWidth(context) *
                                                    0.03),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Close Friends
                            InkWell(
                              onTap: () {
                                Provider.of<categoryManager>(context,
                                        listen: false)
                                    .updateCategory(2);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                //color: Colors.orange[300],
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: (currentCategory == 2)
                                            ? [
                                                Colors.orange[300]!,
                                                Colors.orange[200]!
                                              ]
                                            : unselectedCategory,
                                      ),
                                      borderRadius: BorderRadius.circular(45)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0,
                                        left: 16,
                                        right: 16,
                                        bottom: 6),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/close.png',
                                            height:
                                                displayHeight(context) * 0.028,
                                            fit: BoxFit.cover,
                                          ),
                                          VerticalDivider(
                                            width: displayWidth(context) * 0.02,
                                          ),
                                          Text(
                                            'CLOSE FRIENDS',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.03),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: displayHeight(context) * 0.38,
                child: Container(
                  height: displayHeight(context) * 0.54,
                  width: displayWidth(context),
                  //color: Colors.pinkAccent,
                  child: (isLoading)
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        padding: EdgeInsets.only(left:10,right: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 5,
                            //childAspectRatio: 0.5
                          ),
                          itemCount: friends.length,
                          itemBuilder: (context, index) {
                            return showMyFriends(context, friends[index]);
                          },
                        ),
                ))
          ],
        ));
  }
}
