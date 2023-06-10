class AttendanceResponse {
  AttendanceResponse({
      this.status, 
      this.message, 
      this.data,});

  AttendanceResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Attendance.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<Attendance>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Attendance {
  Attendance({
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
      this.deviceOutTime, 
      this.coordinateOut, 
      this.coordinateIn,});

  Attendance.fromJson(dynamic json) {
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
    coordinateOut = json['coordinate_out'] != null ? CoordinateOut.fromJson(json['coordinate_out']) : null;
    coordinateIn = json['coordinate_in'] != null ? CoordinateIn.fromJson(json['coordinate_in']) : null;
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
  dynamic deviceInTime;
  dynamic deviceOutTime;
  CoordinateOut? coordinateOut;
  CoordinateIn? coordinateIn;

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
    if (coordinateOut != null) {
      map['coordinate_out'] = coordinateOut?.toJson();
    }
    if (coordinateIn != null) {
      map['coordinate_in'] = coordinateIn?.toJson();
    }
    return map;
  }

}

class CoordinateIn {
  CoordinateIn({
      this.id, 
      this.latitude, 
      this.longitude,});

  CoordinateIn.fromJson(dynamic json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  int? id;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

class CoordinateOut {
  CoordinateOut({
      this.id, 
      this.latitude, 
      this.longitude,});

  CoordinateOut.fromJson(dynamic json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  int? id;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}