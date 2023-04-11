

abstract class GellaryStatus {}

class InitialLoadingStatus extends GellaryStatus {}

class LoginLoadingState extends GellaryStatus {}

class LoginSuccessState extends GellaryStatus {
 
  LoginSuccessState();

}

class LoginErrorState extends GellaryStatus {
  final String error;
  LoginErrorState(this.error);
}


class GellaryDataLodingState extends GellaryStatus {}
class GellaryDataSuccessState extends GellaryStatus {}
class GellaryDataErrorState extends GellaryStatus {
  String? error;
  GellaryDataErrorState({this.error});
}

class GetImageSuccessStateState extends GellaryStatus {}


class GetImageErrorStateState extends GellaryStatus {}

//////////upload image
class UploadImageLodingStateState extends GellaryStatus {}
///
class UploadImageSucessStateState extends GellaryStatus {}
class UploadImageErrorStateState extends GellaryStatus {}

class PostImagePickedSuccessState extends GellaryStatus {}
class PostImagePickedErrorState extends GellaryStatus {}












