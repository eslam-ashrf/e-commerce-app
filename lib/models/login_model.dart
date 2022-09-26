class LoginModel {
  late bool status;
  late String message;
  UserData? data;
  LoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UserData.fromJson(json['data']):null;
  }
}
class UserData{
  int? id;
  String?name;
  String?image;
  String?email;
  String?phone;
  int?points;
  int?credit;
  String?token;

  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    image=json['image'];
    phone=json['phone'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }

}
