class LoginResponseModel{
  late bool success;
  late int statuscode;
  late String code;
  late String message;
  late Data data;

  LoginResponseModel({
    required this.data,
    required this.code,
    required this.message,
    required this.statuscode,
    required this.success});

  LoginResponseModel.fromJson(Map<String, dynamic>json){
    code = json['code'];
    message = json['message'];
    statuscode = json['statuscode'];
    success = json['success'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map <String , dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['statuscode'] = this.statuscode;
    data['success'] = this.success;


    if(this.data != null){
      data['data'] = this.data.toJson();
    }

    return data;
  }

}

class Data{
  late String token;
  late int id;
  late String email;
  late String nicename;
  late String firstName;
  late String lastName;
  late String displayName;

  Data({
    required this.email,
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.id,
    required this.nicename,
  });

  Data.fromJson(Map<String, dynamic> json){
    token = json['taken'];
    id = json['id'];
    email = json['email'];
    nicename  = json['nicename'];
    firstName = json['firstName'];
    displayName = json['displayName'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['nicename'] = this.nicename;
    data['firstName'] = this.firstName;
    data['displayName'] = this.displayName;

    return data;
  }
}