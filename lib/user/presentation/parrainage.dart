import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verve/user/presentation/view_model/parainnage_view_model.dart';

import '../../widgets/appbar.dart';

class Parrainage extends StatefulWidget {
  const Parrainage({super.key});

  @override
  State<Parrainage> createState() => _ParrainageState();
}

class _ParrainageState extends State<Parrainage> {
  final ParainageViewModel _viewModel = ParainageViewModel();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _prenomEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();

  _bind() {
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });
    _prenomEditingController.addListener(() {
      _viewModel.setPrenom(_prenomEditingController.text);
    });
    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 34.h,
              ),
              Center(
                child: Text(
                  "Parrainage",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.r),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Entrez les informations de la personnne que vous voulez parrainer",
                      style: GoogleFonts.inter(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 38.h,
                    ),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorUserName,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _userNameEditingController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(233, 250, 254, 1),
                              hintText: "Nom",
                              errorText: snapshot.data,
                              hintStyle: TextStyle(fontSize: 15.sp),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorPrenom,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _prenomEditingController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(242, 250, 235, 1),
                              hintText: "Prénom",
                              errorText: snapshot.data,
                              hintStyle: TextStyle(fontSize: 16.sp),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorMobileNumber,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _mobileNumberEditingController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(233, 250, 254, 1),
                              hintText: "Numéro de Télephone",
                              errorText: snapshot.data,
                              hintStyle: TextStyle(fontSize: 16.sp),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorEmail,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(242, 250, 235, 1),
                              hintText: "Adresse Mail",
                              errorText: snapshot.data,
                              hintStyle: TextStyle(fontSize: 16.sp),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Commentaire...",
                          hintStyle: TextStyle(fontSize: 16.sp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24).w)),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      width: 221.w,
                      height: 53.h,
                      child: StreamBuilder<bool>(
                          stream: _viewModel.outputAreAllInputsValid,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor: (snapshot.data ?? false)
                                    ? const MaterialStatePropertyAll(
                                        Color.fromRGBO(82, 190, 66, 1))
                                    : const MaterialStatePropertyAll(
                                        Colors.grey),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Envoyer",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 93.h,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
