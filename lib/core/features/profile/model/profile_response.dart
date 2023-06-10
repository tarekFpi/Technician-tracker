class ProfileResponse {
  ProfileResponse({
      this.status, 
      this.message, 
      this.data,});

  ProfileResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  ProfileData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class ProfileData {
  ProfileData({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.address, 
      this.code,});

  ProfileData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    code = json['code'];
  }
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['code'] = code;
    return map;
  }

}