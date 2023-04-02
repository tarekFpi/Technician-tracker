class AttendanCheckInResponse {
  AttendanCheckInResponse({
      this.status, 
      this.message, 
      this.data,});

  AttendanCheckInResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

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

class Data {
  Data({
      this.userId, 
      this.date, 
      this.inTime, 
      this.status, 
      this.coordinateInId, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    date = json['date'];
    inTime = json['in_time'];
    status = json['status'];
    coordinateInId = json['coordinate_in_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? userId;
  String? date;
  String? inTime;
  String? status;
  int? coordinateInId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['date'] = date;
    map['in_time'] = inTime;
    map['status'] = status;
    map['coordinate_in_id'] = coordinateInId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}