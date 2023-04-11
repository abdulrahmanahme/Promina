import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';
import 'package:promina/model/data_model.dart' as getData;
import 'package:promina/model/user_model.dart' as getuser;
import 'package:promina/view_model.dart/cubit/states.dart';
import 'package:promina/view_model.dart/dio/dio.dart';
import 'package:promina/view_model.dart/dio/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../local/CacheService.dart';

class GellaryCubit extends Cubit<GellaryStatus> {
  GellaryCubit() : super(InitialLoadingStatus());
  static GellaryCubit get(context) => BlocProvider.of(context);

  var token =
       "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTMxNjI3ODZmYTdiM2M1MzI3YzJlY2UxMTAzYzFkMjhkNjhhOGIyYTdmNTg0NzcyNzk2NTVmZDZmYjcyNTNhNjlhNTU1MjkzNTAyODk4M2MiLCJpYXQiOjE2ODEyMjY2NjIuMzg5MzUxLCJuYmYiOjE2ODEyMjY2NjIuMzg5MzU0LCJleHAiOjE3MTI4NDkwNjIuMzg4MjQsInN1YiI6IjE2MiIsInNjb3BlcyI6W119.bTMs8Q54Mx-oKD4xtJg5ICUQpl6dScsDH0x_CaIjcABdKyubhA3X5rUMREEKkanug1VHgRIxSlZ0b4EUzh_MMAhPpmYhEH_kYDLjZQC3jEKf3D1Sip13C81BmUxyiA4Vv3vkxiznbsNKlkDRyEq_nsNJsk7xqrZ7WRapl9YE53GEwxEZal2issXCt-fX8GkNFw8WiQPMll0s3w98Col7RCyIWsd26W1StCLX_Ey2Tl6f_VRk5SPuZN9zjRDRY9jLneOI3GCNmk-ae4hu5cWk6_u0WWa6gNF_H6H4tDQYFjoKkpCC8CvQd-bVN9fTt34UMdhhqJJ_u6-Q4eUX7uY2jat6b4l06kPPKOUB2oE7sY91JjeznOc0j5G_3SIPeCzQdOD2AgcjUL-FJVYtXiEMXUv63LEn81S5EJn5xP6-8XRh11Lve4gF2SFim4QyI-Kx1gKPdcc_F50mUPyRzXBBO_DuV8xZeGprIKWRTpO4OPRDompz1T56QbUhFkzc4egPqowZwfWuHbzxp6MYiRWDcyfX3pxuqu4sttRb8Vo6sJZo-9d2FXdxFUzTATO__sFhdPhN-nxL7N2_9i6_Os0u5o0XHnvd-pFem8ZsLbSQ3HyVqU00FmcR8uKOGQOpkOy_FfLqQvJO9EvVzCUYnBOLkEoLWdnbfS7dvX-MeU4N04w";
  getuser.UserModel? userModel;
  getData.Data? data;
  List<String> proudcts = [];
  getData.DataModel? dataModel;

  void getProducts() {
    emit(GellaryDataLodingState());
    DioHelper.getData(url: BaseRULAPP.myGellary, token:token ).then((value) {
      dataModel = getData.DataModel.fromJson(value.data);
      // var map =Map.from((dataModel))
//  var  data  = List<String>.from(dataModel!.data!.images!.map((x) =>print('$x') ));
      // print('from mapp${ data }');

      print('ddddddddddddddddddddddddddddd${dataModel!.data!.images!.length}');
      proudcts = dataModel!.data!.images!;
      // print('tttttt${dataModel!.data!.images!.length}');
      // for(var image in proudcts){
      //    proudcts.add(image);
      //    print('$image');
      // }

      emit(GellaryDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(GellaryDataErrorState());
      }
    });
  }

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: BaseRULAPP.login, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = getuser.UserModel.fromJson(value.data);
      // userData = UserData.fromJson(value.data);
      print('LLLLLL ${userModel!.user!.name!}  LL');
      print('LLLLLL ${userModel!.user!.email!}  LL');
      print('LLLLLL ${userModel!.user!.createdAt!}  LL');
   var token  = CacheService.cacheData(key: 'token' ,value:userModel!.token );
        print(
            'eeeeeeeeeeeeeeeL${token}eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');


      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        // print(
        //  'eeeeeeeeeeeeeeeL${error.response!.statusMessage}eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        emit(LoginErrorState(error.message));
      }
    });
  }

  File? imageCamera;
  Future<void> ImageCamera() async {
    final ImagePicker _pickerCamera = ImagePicker();
    final XFile? pickedCameraFile =
        await _pickerCamera.pickImage(source: ImageSource.camera);

    if (pickedCameraFile != null) {
      imageCamera = File(pickedCameraFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('NO Image print');
      emit(PostImagePickedErrorState());
    }
  }

  File? gelleryImage;

  Future<void> GelleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      gelleryImage = File(pickedFile.path);

      emit(GetImageSuccessStateState());
    } else {
      print('NO Image print');
      emit(GetImageErrorStateState());
    }
  }

  void createPost({
    required String? image,
  }) {
    emit(UploadImageLodingStateState());
    DioHelper.postData(
            url:  BaseRULAPP.upload,
            data: {
              "img": image!,
            },
            token: CacheService.token.toString())
        .then((value) {
      emit(UploadImageSucessStateState());
      print('------------------UPLOAD DONE -----------------------');
    }).catchError((error) {
      if (error is DioError) {
        emit(UploadImageErrorStateState());
      }
    });
  }
}
