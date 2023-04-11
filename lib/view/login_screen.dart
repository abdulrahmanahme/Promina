import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/components/components.dart';
import 'package:promina/view/gellary_screen.dart';
import 'package:promina/view_model.dart/cubit/cubit.dart';
import 'package:promina/view_model.dart/cubit/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var controlleremail = TextEditingController();
var controllerpassword = TextEditingController();
final formkey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GellaryCubit>(
        create: (BuildContext context) => GellaryCubit(),
        child: BlocConsumer<GellaryCubit, GellaryStatus>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              // CacheHelper.setData(key:SharedKeys.token , value: '${state.userData!.data!.accessToken}');
              print('ssssssssssssssssssssssssssssssssssssssssssssssss');
              navigateAndFinish(context, GellarryScreen());

              // showToast(text: '${state.userData!.message}', state: ToastStates.SUCCESS);
            }
          },
          builder: (context, state) {
            var cubit = GellaryCubit.get(context);
cubit.getProducts();
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/gallery.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 29.w, top: 2.h),
                              child: Container(
                                height: 125,
                                width: 125,
                                decoration: const BoxDecoration(
                                  // color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cameraa.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'My',
                          style: TextStyle(
                            fontSize: 31.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff4A4A4A),
                          ),
                        ),
                        Text(
                          'Gellary',
                          style: TextStyle(
                            fontSize: 31.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff4A4A4A),
                          ),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
                            child: Container(
                              height: 43.h,
                              width: 90.w,
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.4),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        // color: Colors.amber,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/log in (3).png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2.5, sigmaY: 2.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'LOG IN',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff4A4A4A),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      defaultFormField(
                                        controller: controlleremail,
                                        hintText: 'User Name',
                                        validate: (value) {
                                          if (!value!.contains('@') ||
                                              value.isEmpty) {
                                            return 'Invalid Email!';
                                          }

                                          return null;
                                        },
                                        type: TextInputType.emailAddress,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      defaultFormField(
                                        controller: controllerpassword,
                                        hintText: 'Password',
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }

                                          return null;
                                        },
                                        type: TextInputType.visiblePassword,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      state is LoginLoadingState
                                          ? CircularProgressIndicator()
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0xff7BB3FF),
                                                padding: EdgeInsets.only(
                                                    top: 1.7.h,
                                                    bottom: 1.7.h,
                                                    left: 11.h,
                                                    right: 11.h),
                                                elevation: 6,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                'SUBMIT',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  cubit.userLogin(
                                                      email:
                                                          controlleremail.text,
                                                      password:
                                                          controllerpassword
                                                              .text);
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
