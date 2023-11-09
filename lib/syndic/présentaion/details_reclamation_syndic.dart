import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../user/data/realm/database.dart';
import '../../user/data/realm/realm.dart';
import '../../widgets/appbar.dart';

class DetailsReclamationSyndic extends StatefulWidget {
  const DetailsReclamationSyndic({super.key});

  @override
  State<DetailsReclamationSyndic> createState() =>
      _DetailsReclamationSyndicState();
}

class _DetailsReclamationSyndicState extends State<DetailsReclamationSyndic> {
  var arguments = Get.arguments;
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;

  static List<File> selectedImages = []; // List of selected image
  static final picker = ImagePicker();
  final TextEditingController _commentEditingController =
      TextEditingController();

  void _updateStatus(String newStatus, Reclamation reclamation) {
    String? newColor;

    switch (newStatus) {
      case 'Ouverte':
        newColor = 'green';
        break;
      case 'Prise en charge':
        newColor = 'blue';
        break;
      case 'traité':
        newColor = 'red';
        break;
      default:
        newColor = null;
    }

    realm.write(() {
      reclamation.status = newStatus;
      reclamation.color = newColor;
    });

    setState(() {});
  }

  void _addImageToConfirm(String image, Reclamation reclamation) {
    realm.write(() => {reclamation.imageconfirmed = image});
    setState(() {});
  }

  bool isLoading = false;

  Future getImages(BuildContext context) async {
    {
      final pickedFile = await picker.pickMultiImage(
          imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
      List<XFile> xfilePick = pickedFile;
      if (xfilePick.isNotEmpty) {
        for (var i = 0; i < xfilePick.length; i++) {
          selectedImages.add(File(xfilePick[i].path));
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Images Selected'),
          duration: Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Rien n\'est sélectionné ?'),
          duration: Duration(seconds: 1),
        ));
      }
    }
  }

  void updatedata() {
    if (_commentEditingController.text.isNotEmpty &&
        selectedImages.isNotEmpty) {
      _updateStatus("traité", arguments);
      _addImageToConfirm(selectedImages.first.path, arguments);
      Get.back();
      Get.back();
      Get.back();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Rien n'est sélectionné ?"),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedImages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:MyAppBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 61.h,
                ),
                Center(
                  child: Text(
                    "Reclamation à propos de:",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 20.sp),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Text(arguments.problem,style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
                SizedBox(
                  height: 67.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  width: 327.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      border: Border.all(color: Colors.grey)),
                  child: GestureDetector(
                    onTap: () {
                      getImages(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insérer des Photos",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: Color.fromRGBO(135, 135, 135, 1)),
                        ),
                        Image(
                          image: const AssetImage("assets/photo.png"),
                          width: 40.w,
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 53.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  child: TextFormField(
                    controller: _commentEditingController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Commentaire...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r))),
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.r),
                    width: 327.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          updatedata();
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(82, 190, 66, 1))),
                      child: Text(
                        "Envoyer",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 63.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
