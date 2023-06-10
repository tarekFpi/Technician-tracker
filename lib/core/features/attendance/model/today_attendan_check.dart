class TodayAttendanCheck {
  TodayAttendanCheck({
      this.status, 
      this.message, 
      this.data,});

  TodayAttendanCheck.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TodayAttendan.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  TodayAttendan? data;

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

class TodayAttendan {
  TodayAttendan({
      this.id, 
      this.userId, 
      this.date, 
      this.inTime, 
      this.outTime, 
      this.status, 
      this.coordinateInId, 
      this.coordinateOutId, 
      this.createdAt, 
      this.updatedAt, 
      this.deviceInTime, 
      this.deviceOutTime,});

  TodayAttendan.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    status = json['status'];
    coordinateInId = json['coordinate_in_id'];
    coordinateOutId = json['coordinate_out_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceInTime = json['device_in_time'];
    deviceOutTime = json['device_out_time'];
  }
  int? id;
  int? userId;
  String? date;
  String? inTime;
  String? outTime;
  String? status;
  int? coordinateInId;
  int? coordinateOutId;
  String? createdAt;
  String? updatedAt;
  String? deviceInTime;
  dynamic deviceOutTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['date'] = date;
    map['in_time'] = inTime;
    map['out_time'] = outTime;
    map['status'] = status;
    map['coordinate_in_id'] = coordinateInId;
    map['coordinate_out_id'] = coordinateOutId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['device_in_time'] = deviceInTime;
    map['device_out_time'] = deviceOutTime;
    return map;
  }

}