import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../di.dart';
import '../user/data/app_preferences.dart';

PreferredSizeWidget MyAppBar(BuildContext context) {
  AppPreferences _appPreferences = instance<AppPreferences>();

  return AppBar(
      elevation: 0,
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.blue,
          )),
      backgroundColor: Colors.white,
      title: Image.asset("assets/logo.png", height: 60.h, width: 60.w),
      centerTitle: true,
      leading: IconButton(
        icon: Image.asset("assets/notify.png", width: 60.w, height: 60.h),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Image.asset("assets/profile.png", width: 60.w, height: 60.h),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset("assets/logout.png", width: 60.w, height: 60.h),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Êtes-vous sûr de vouloir vous déconnecter"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _appPreferences.logout();
                            },
                            child: Text(
                              "Oui",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp,color: Colors.black),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Non",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp,color: Colors.black),
                            )),
                      ],
                    ));
          },
        ),
      ]);
}
