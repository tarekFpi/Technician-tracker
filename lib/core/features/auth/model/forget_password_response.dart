class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.status, 
      this.message, 
   });

  ForgetPasswordResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];

  }
  bool? status;
  String? message;
  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;

    return map;
  }

}