import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve/syndic/pr%C3%A9sentaion/process_reclamation_syndic.dart';

import '../../user/data/realm/database.dart';
import '../../user/data/realm/realm.dart';
import '../../widgets/appbar.dart';

class ListeReclamationSyndic extends StatefulWidget {
  const ListeReclamationSyndic({super.key});

  @override
  State<ListeReclamationSyndic> createState() => _ListeReclamationSyndicState();
}

class _ListeReclamationSyndicState extends State<ListeReclamationSyndic> {
  List<Reclamation> list = [];
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;

  Color? _getButtonColor(String status, Reclamation reclamation) {
    Map<String, Color> colorMap = {
      'Ouverte': Color.fromRGBO(238, 238, 238, 1.0),
      'Prise en charge': Color.fromRGBO(217, 235, 241, 1.0),
      'traité': Color.fromRGBO(242, 250, 235, 1.0),
    };

    return reclamation.status == status ? colorMap[status] : null;
  }

  Widget? _getWidget(String status, Reclamation reclamation) {
    Map<String, Widget> colorMap = {
      'Ouverte': Text("Nouvelle Reclamation"),
      'Prise en charge': Text("Prise En charge"),
      'traité': Image.asset("assets/done.png", height: 18.h, width: 18.w),
    };

    return reclamation.status == status ? colorMap[status] : null;
  }

  @override
  void initState() {
    list = realm.all<Reclamation>().toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _expensesSub ??= realm.all<Reclamation>().changes.listen((changes) {
      setState(() {
        list = changes.results.toList();
      });
    });

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: Column(
          children: [
            SizedBox(
              height: 61.h,
            ),
            Center(
              child: Text(
                "Liste des réclamations",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
            ),
            SizedBox(
              height: 60.r,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (list.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(right: 26.r,left:31.r),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const ProcessReclamtionSyndic(),
                                arguments: list[index]);
                          },
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 28.w,
                                height: 29.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                    color:
                                        Color.fromRGBO(38, 202, 245, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "$index",
                                    style: GoogleFonts.inter(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 26.r),
                                color: _getButtonColor(
                                    list[index].status!, list[index]),
                                width: 279.w,
                                height: 85.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.r, vertical: 12.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("N "),
                                                  Text("${index}"
                                                      .toString()
                                                      .padLeft(3, "0")),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              _getWidget(list[index].status!,
                                                  list[index])!
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            list[index].problem!,
                                            style: GoogleFonts.inter(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "Problémes: ${list[index].commentaire!.substring(0,20)}",
                                            maxLines: 1,
                                            style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight:
                                                    FontWeight.w300),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                          "${list[index].date?.day}/${list[index].date?.month}/${list[index].date?.year} "),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
