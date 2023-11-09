import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verve/user/data/realm/database.dart';

import '../../user/data/realm/realm.dart';
import '../../widgets/appbar.dart';
import 'details_reclamation_syndic.dart';

class ProcessReclamtionSyndic extends StatefulWidget {
  const ProcessReclamtionSyndic({super.key});

  @override
  State<ProcessReclamtionSyndic> createState() =>
      _ProcessReclamtionSyndicState();
}

class _ProcessReclamtionSyndicState extends State<ProcessReclamtionSyndic> {
  var arguments = Get.arguments;
  static List<File> selectedImages = []; // List of selected image
  static final picker = ImagePicker();

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
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    setState(() {
      isLoading = true;
    });

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }

      setState(() {
        isLoading = false;
      });

      Get.back();
      Get.back();

      _addImageToConfirm(selectedImages.first.path, arguments);
      _updateStatus("traité", arguments);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Images Selected'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Rien n\'est sélectionné ?'),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: Column(
          children: [
            SizedBox(
              height: 62.h,
            ),
            Center(
              child: Image.file(
                File(arguments.images),
                fit: BoxFit.cover,
                width: 187.w,
                height: 134.h,
              ),
            ),
            SizedBox(
              height: 93.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        "${arguments.date?.day}/${arguments.date?.month}/${arguments.date?.year}  ${arguments.date?.hour}:${arguments.date?.minute}",
                        style: GoogleFonts.inter(
                            fontSize: 13.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        arguments.problem,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 190.w,
                        height: 60.h,
                        child: Text(
                          "Problémes: ${arguments.commentaire!}",
                          maxLines: 6,
                          style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      Container(
                        width: 106.w,
                        height: 22.h,
                        child: ElevatedButton(
                          onPressed: arguments.status != "traité"
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                              Text("Ouvrir une réclamation "),
                                          title: Text(
                                            "Rendre Ouverte?",
                                            style: GoogleFonts.inter(
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                          shape: BeveledRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.r))),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  _updateStatus(
                                                      'Ouverte', arguments);
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: Text("oui")),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("Non")),
                                          ],
                                        );
                                      });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r))),
                              primary: arguments.status == 'Ouverte'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).disabledColor),
                          child: Text(
                            'Ouverte',
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: arguments.status == "traité"
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: 106.w,
                        height: 22.h,
                        child: ElevatedButton(
                          onPressed: arguments.status != "traité"
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                              "Réclamation est en prise en charge",
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            content: Text(
                                              "Avez-vous confirmé que la réclamation est en prise en charge?",
                                              style: GoogleFonts.inter(),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _updateStatus(
                                                        'Prise en charge',
                                                        arguments);
                                                    Get.back();
                                                    Get.back();
                                                  },
                                                  child: Text("yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text("Non"))
                                            ],
                                          ));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r))),
                              primary: arguments.status == 'Prise en charge'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).disabledColor),
                          child: Text(
                            'Prise en charge',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: arguments.status == "traité"
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: 106.w,
                        height: 22.h,
                        child: ElevatedButton(

                          onPressed: arguments.status != "traité"
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              " la réclamation est en cours de traitement?"),
                                          content: const Text(
                                              "Pourriez-vous prendre une photo pour confirmer que la réclamation a été traitée?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Get.to(
                                                      DetailsReclamationSyndic(),
                                                      arguments: arguments);
                                                },
                                                child: Text("Oui")),
                                            TextButton(
                                                onPressed: () async {
                                                  Get.back();
                                                },
                                                child: Text("Non")),
                                          ],
                                        );
                                      });
                                }
                              : null,
                          style: arguments.status == "traité"
                              ? ElevatedButton.styleFrom(
                              onSurface: Colors.green.shade700,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.r))))
                              : ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.r)))),
                          child: Text(
                            'traité',
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: arguments.status == "traité"
                                    ? Colors.green
                                    : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
