import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/custom_paint.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class imageScreen extends StatefulWidget {
  final String? dpImage;
  final String? docId;
  final String? gender;

  imageScreen({this.dpImage, this.docId,this.gender});

  @override
  State<imageScreen> createState() => _imageScreenState();
}

class _imageScreenState extends State<imageScreen> {
  User? currentUser;
  bool? isUploading = false;
  List<dynamic> imageList = [];
  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;

    super.initState();
  }

  final picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          _imageFile = File(pickedFile!.path);
        });
      }
    }

    showImages(BuildContext ctx, String url) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: ctx,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Dialog(
                  insetAnimationCurve: Curves.easeInOutQuad,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          //color: Colors.pink,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: url,
                fadeInCurve: Curves.easeInOutCubicEmphasized,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return SpinKitHourGlass(
                    color: Colors.black54,
                    size: displayWidth(context) * 0.2,
                  );
                },
              )),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: (widget.dpImage != null)
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.dpImage!),
                      radius: displayWidth(context) * 0.05,
                    )
                  : CircleAvatar(
                    backgroundImage: AssetImage(widget.gender=='Male'?'images/male.jpg':'images/female.jpg'),
                    radius: displayWidth(context) * 0.05,
                  ),
            ),
          ],
          title: Text(
            'Snapshots',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: displayWidth(context) * 0.055),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[300],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await pickImage().then((value) async {
              await Future.delayed(Duration(seconds: 1, microseconds: 5000))
                  .then((value) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: displayHeight(context) * 0.4,
                      color: Colors.white,
                      child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.loose,
                          children: [
                            Positioned(
                              child: CustomPaint(
                                child: Container(
                                  height: displayHeight(context) * 0.1,
                                  width: displayWidth(context),
                                ),
                                painter: CurvePainter(),
                              ),
                              top: 0,
                            ),
                            Positioned(
                                top: displayHeight(context) * 0.13,
                                left: displayWidth(context) * 0.08,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _imageFile!,
                                    height: displayHeight(context) * 0.2,
                                    width: displayWidth(context) * 0.35,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                                top: displayHeight(context) * 0.15,
                                right: displayWidth(context) * 0.1,
                                child: Text(
                                  "Upload this image ?",
                                  style: TextStyle(
                                    overflow: TextOverflow.clip,
                                    color: Colors.orange[300],
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.04,
                                  ),
                                )),
                            Positioned(
                                bottom: displayHeight(context) * 0.12,
                                left: displayWidth(context) * 0.52,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red[200])),
                                  onPressed: () {
                                    setState(() {
                                      _imageFile = null;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            Positioned(
                                bottom: displayHeight(context) * 0.12,
                                right: displayWidth(context) * 0.1,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green[300])),
                                  onPressed: () async {
                                    Provider.of<FriendsManager>(context,
                                            listen: false)
                                        .updateImageList(currentUser!.uid,
                                            widget.docId!, _imageFile)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Successfully uploaded image ! It may take some time to reflect changes across the app'),
                                      duration: Duration(seconds: 10),
                                    ));
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ]),
                    );
                  },
                );
              });
            });
          },
          elevation: 5,
        ),
        body: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(currentUser!.uid)
                    .doc(widget.docId)
                    .collection('images')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Image.asset(
                        'images/bb.png',
                        fit: BoxFit.fitHeight,
                        height: displayHeight(context) * 0.3,
                      ),
                    );
                  }
                  return GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        print(snapshot.data.docs[index].data()['url']);
                        return showImages(
                            context, snapshot.data.docs[index].data()['url']);
                      });
                }),
          ),
        ));
  }
}
