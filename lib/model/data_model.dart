
class DataModel {
  String? _status;
  Data? _data;
  String? _message;

  DataModel({String? status, Data? data, String? message}) {
    if (status != null) {
      this._status = status;
    }
    if (data != null) {
      this._data = data;
    }
    if (message != null) {
      this._message = message;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  Data? get data => _data;
  set data(Data? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  DataModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['message'] = this._message;
    return data;
  }
}

class Data {
  List<String>? _images;

  Data({List<String>? images}) {
    if (images != null) {
      this._images = images;
    }
  }

  List<String>? get images => _images;
  set images(List<String>? images) => _images = images;

  Data.fromJson(Map<String, dynamic> json) {
    _images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this._images;
    return data;
  }
}