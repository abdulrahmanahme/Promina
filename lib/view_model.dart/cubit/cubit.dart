import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:promina/model/data_model.dart';
import 'package:promina/model/user_model.dart';
import 'package:promina/view_model.dart/cubit/states.dart';
import 'package:promina/view_model.dart/dio/dio.dart';
import 'package:promina/view_model.dart/dio/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../local/CacheService.dart';

class GellaryCubit extends Cubit<GellaryStatus> {
  GellaryCubit() : super(InitialLoadingStatus());
  static GellaryCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  Data? data;
  List<String> imagesList = [];
  DataModel? dataModel;
  void getListOfImages() {
    emit(GellaryDataLodingState());
    DioHelper.getData(url: BaseRULAPP.myGellary, token:CacheService.token.toString())
        .then((value) {
      dataModel = DataModel.fromJson(value.data);
      imagesList = dataModel!.data!.images!;
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
    DioHelper.postData(url: BaseRULAPP.login, token:CacheService.token.toString() ,data: {
      "email": email,
      "password": password,
      
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      var token = CacheService.cacheData(key: 'token', value: userModel!.token);

      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioError) {
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
            url: BaseRULAPP.upload,
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
