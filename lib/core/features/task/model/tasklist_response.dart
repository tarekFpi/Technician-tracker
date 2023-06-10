class TasklistResponse {
  TasklistResponse({
      this.status, 
      this.message, 
      this.data,});

  TasklistResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TaskResponse.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<TaskResponse>? data;

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

class TaskResponse {
  TaskResponse({
      this.id, 
      this.categoryId, 
      this.assigneeUserId, 
      this.priorityId, 
      this.statusId, 
      this.title, 
      this.description, 
      this.date, 
      this.time, 
      this.latitude, 
      this.longitude, 
      this.isActive, 
      this.createdBy, 
      this.updatedBy, 
      this.createdAt, 
      this.updatedAt, 
      this.assigne, 
      this.category, 
      this.priority, 
      this.status, 
      this.coordinates,});

  TaskResponse.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    assigneeUserId = json['assignee_user_id'];
    priorityId = json['priority_id'];
    statusId = json['status_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  int? categoryId;
  int? assigneeUserId;
  int? priorityId;
  int? statusId;
  String? title;
  String? description;
  String? date;
  String? time;
  String? latitude;
  String? longitude;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Assigne? assigne;
  Category? category;
  Priority? priority;
  Status? status;
  List<Coordinates>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['assignee_user_id'] = assigneeUserId;
    map['priority_id'] = priorityId;
    map['status_id'] = statusId;
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_active'] = isActive;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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
      this.longitude, 
      this.createdAt, 
      this.updatedAt,});

  Coordinates.fromJson(dynamic json) {
    id = json['id'];
    taskId = json['task_id'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? taskId;
  String? time;
  String? latitude;
  String? longitude;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['task_id'] = taskId;
    map['time'] = time;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Status {
  Status({
      this.id, 
      this.code, 
      this.name, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  Status.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? code;
  String? name;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Priority {
  Priority({
      this.id, 
      this.code, 
      this.name, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  Priority.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? code;
  String? name;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Category {
  Category({
      this.id, 
      this.code, 
      this.name, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? code;
  String? name;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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
      this.locationId, 
      this.isActive, 
      this.roleId, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.lastSeen, 
      this.code,});

  Assigne.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    locationId = json['location_id'];
    isActive = json['is_active'];
    roleId = json['role_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastSeen = json['last_seen'];
    code = json['code'];
  }
  int? id;
  String? name;
  String? email;
  String? mobile;
  dynamic address;
  dynamic locationId;
  int? isActive;
  int? roleId;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? lastSeen;
  dynamic code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['location_id'] = locationId;
    map['is_active'] = isActive;
    map['role_id'] = roleId;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['last_seen'] = lastSeen;
    map['code'] = code;
    return map;
  }

}