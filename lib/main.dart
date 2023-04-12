import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/view/login_screen.dart';
import 'package:promina/view_model.dart/cubit/cubit.dart';
import 'package:promina/view_model.dart/dio/dio.dart';
import 'package:promina/view_model.dart/local/CacheService.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheService.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<GellaryCubit>(
            create: (BuildContext context) => GellaryCubit()..getListOfImages(),
          ),
        ],
        child: MaterialApp(
          title: 'ProMina',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen(),
        ),
      );
    });
  }
}
