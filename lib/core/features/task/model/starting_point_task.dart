class StartingPointTask {
  StartingPointTask({
      this.status, 
      this.message, 
      this.data,});

  StartingPointTask.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TaskStatus.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  TaskStatus? data;

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

class TaskStatus {
  TaskStatus({
      this.id, 
  /*    this.categoryId,
      this.assigneeUserId, 
      this.priorityId, 
      this.statusId, 
      this.title, 
      this.description, */
   /*   this.date,
      this.time, 
      this.latitude, 
      this.longitude, 
      this.isActive, 
      this.createdBy, 
      this.updatedBy, 
      this.createdAt, 
      this.updatedAt,*/});

  TaskStatus.fromJson(dynamic json) {
    id = json['id'];
/*    categoryId = json['category_id'];
    assigneeUserId = json['assignee_user_id'];
    priorityId = json['priority_id'];
    statusId = json['status_id'];
    title = json['title'];
    description = json['description'];*/
 /*   date = json['date'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];*/
  }

  int? id;
   int? categoryId;
  int? assigneeUserId;
  int? priorityId;
  String? statusId;
  String? title;
  String? description;
  String? date;
  String? time;
  String? latitude;
  String? longitude;
/*  int? isActive;
  int? createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? updatedAt;*/




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
/*  map['is_active'] = isActive;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;*/
    return map;
  }

}