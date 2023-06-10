class TaskDetailsResponse {
  TaskDetailsResponse({
      this.status, 
      this.message, 
      this.data,});

  TaskDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TaskDetails.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  TaskDetails? data;

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

class TaskDetails {
  TaskDetails({
      this.id, 
      this.title, 
      this.description, 
      this.date, 
      this.time, 
      this.latitude, 
      this.longitude, 
      this.isActive, 
      this.assigne, 
      this.category, 
      this.priority, 
      this.status, 
      this.coordinates,});

  TaskDetails.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    assigne = json['assigne'] != null ? Assigne.fromJson(json['assigne']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    priority = json['priority'] != null ? Priority.fromJson(json['priority']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['coordinates'] != null) {
      coordinates = [];
      json['coordinates'].forEach((v) {
        coordinates?.add(Coordinates.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  String? latitude;
  String? longitude;
  int? isActive;
  Assigne? assigne;
  Category? category;
  Priority? priority;
  Status? status;
  List<Coordinates>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_active'] = isActive;
    if (assigne != null) {
      map['assigne'] = assigne?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (priority != null) {
      map['priority'] = priority?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (coordinates != null) {
      map['coordinates'] = coordinates?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Coordinates {
  Coordinates({
      this.id, 
      this.taskId, 
      this.time, 
      this.latitude, 
      this.longitude,});

  Coordinates.fromJson(dynamic json) {
    id = json['id'];
    taskId = json['task_id'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  int? id;
  int? taskId;
  String? time;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['task_id'] = taskId;
    map['time'] = time;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

class Status {
  Status({
      this.id, 
      this.code, 
      this.name,});

  Status.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }
  int? id;
  String? code;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    return map;
  }

}

class Priority {
  Priority({
      this.id, 
      this.code, 
      this.name,});

  Priority.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }
  int? id;
  String? code;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    return map;
  }

}

class Category {
  Category({
      this.id, 
      this.code, 
      this.name,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }
  int? id;
  String? code;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    return map;
  }

}

class Assigne {
  Assigne({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.address, 
      this.locationId,});

  Assigne.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    locationId = json['location_id'];
  }
  int? id;
  String? name;
  String? email;
  String? mobile;
  dynamic address;
  dynamic locationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['location_id'] = locationId;
    return map;
  }

}