import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/components/components.dart';
import 'package:promina/view/login_screen.dart';
import 'package:promina/view_model.dart/cubit/cubit.dart';
import 'package:promina/view_model.dart/cubit/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GellarryScreen extends StatefulWidget {
  const GellarryScreen({super.key});

  @override
  State<GellarryScreen> createState() => _GellarryScreenState();
}

var controlleremail = TextEditingController();
var controllerpassword = TextEditingController();
final formkey = GlobalKey<FormState>();

class _GellarryScreenState extends State<GellarryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GellaryCubit>(
      create: (BuildContext context) => GellaryCubit(),
      child: BlocConsumer<GellaryCubit, GellaryStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GellaryCubit.get(context);
          cubit.getListOfImages();
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/gellary2.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: .5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Text(
                                  'Wellcome\n marion',
                                  style: TextStyle(
                                    fontSize: 21.sp,
                                    color:const Color(0xff4A4A4A),
                                  ),
                                )),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 9.w,bottom: 3.h),
                              child:const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    AssetImage('assets/images/imageof.jpeg'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          ButtonIcon(
                            heroTag: 'tag 2',
                            asset: 'assets/images/logout.png',
                            textcolor: Color(0xff4A4A4A),
                            colorbutton: Colors.white,
                            text: 'Log out',
                            function: (() {
                              navigateAndFinish(context, LoginScreen());
                            }),
                          ),
                          Spacer(),
                          ButtonIcon(
                            heroTag: 'tag 1',
                            asset: 'assets/images/upload.png',
                            textcolor: Color(0xff4A4A4A),
                            colorbutton: Colors.white,
                            text: 'Upload',
                            function: (() {
                              showDialog(
                                  barrierColor: Color.fromARGB(1, 2, 1, 1),
                                  context: context,
                                  builder: (BuildContext context) => dialog(
                                        function1: () async {
                                          await cubit.GelleryImage();
                                          if (cubit.gelleryImage != null)
                                            cubit.createPost(
                                                image: cubit.gelleryImage
                                                    .toString());
                                          Navigator.pop(context);
                                        },
                                        function2: () async {
                                          await cubit.ImageCamera();
                                          if (cubit.imageCamera != null)
                                            cubit.createPost(
                                                image: cubit.imageCamera
                                                    .toString());

                                          Navigator.pop(context);
                                        },
                                      ));
                            }),
                          ),
                        ],
                      ),
                      cubit.imagesList.isNotEmpty
                          ? SizedBox(
                              child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.all(20),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                  children: List.generate(5, (index) {
                                    return CardWidget(
                                      image: cubit.imagesList[index],
                                    );
                                  })),
                            )
                          : const Center(child: CircularProgressIndicator()),

                      // Cont
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
