import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/appbar.dart';
import '../data/realm/database.dart';

class ProcessReclamtionUser extends StatefulWidget {
  const ProcessReclamtionUser({super.key});

  @override
  State<ProcessReclamtionUser> createState() => _ProcessReclamtionUserState();
}

class _ProcessReclamtionUserState extends State<ProcessReclamtionUser> {
  var arguments = Get.arguments;

  Widget? _getWidgetFinal(String status, Reclamation reclamation) {
    Map<String, Widget> colorMap = {
      'Ouverte': _widgetOuverte(),
      'Prise en charge': _widgetPriseEnCharge(),
      'traité': _widgetTraite(reclamation.imageconfirmed!),
    };

    return reclamation.status == status ? colorMap[status] : null;
  }



  Widget _widgetOuverte() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 79.h,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 68.h,
            ),
            Image.asset("assets/done.png", height: 40.h, width: 40.w),
            SizedBox(width: 14.w,),
            Text(
              "Votre réclamation est ouverte",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                  color: Colors.black),
            )
          ],
        ),
      ],
    );
  }

  Widget _widgetPriseEnCharge() {
    return Column(
      children: [
        SizedBox(
          height: 68.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Image.asset("assets/done.png", height: 40.h, width: 40.w,fit: BoxFit.cover,),
              ],
            ),
            SizedBox(
              width: 16.w,
            ),
            Wrap(
              children: [
                Container(
                  width: 259.w,
                  height: 80.h,
                  child: Text(
                    "Votre réclamation a été prise en charge par monsieur Amine ...",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: Colors.black),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _widgetTraite(String image) {
    return Column(
      children: [
        SizedBox(
          height: 12.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/done.png"),
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              "Votre réclamation est traitée",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                  color: Colors.black),
            )
          ],
        ),
        SizedBox(
          height: 26.h,
        ),
        Image.file(File(image), width: 187.w, height: 137.h,fit: BoxFit.cover,),
        SizedBox(
          height: 16.h,
        ),
        Text(
          "Vous êtes satisfait?",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
              color: Colors.black),
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/happy.png",
                width: 48.w,
                height: 48.h,
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/medium.png",
                width: 48.w,
                height: 48.h,
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/sad.png",
                width: 48.w,
                height: 48.h,
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:MyAppBar(context),
        body: SingleChildScrollView(
          child: Column(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              "${arguments.date?.day}/${arguments.date?.month}/${arguments.date?.year}  ${arguments.date?.hour}:${arguments.date?.minute.toStringAsFixed(1)}",
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
                              height: 4.h,
                            ),
                            Container(
                              width: 190.w,
                              height: 60.h,
                              child: Text(
                                "Problémes: ${arguments.commentaire}...",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Container(
                              width: 106.w,
                              height: 22.h,
                              margin: EdgeInsets.symmetric(vertical: 6.r),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r))),
                              child: Center(
                                child: Text(arguments.status,
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 68.h,
                        ),
                      ],
                    ),
                    _getWidgetFinal(arguments.status, arguments)!
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
