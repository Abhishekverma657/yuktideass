class TermaAndConditonModel {
  bool? status;
  String? message;
  Data? data;

  TermaAndConditonModel({this.status, this.message, this.data});

  TermaAndConditonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? content;
  String? publishedAt;
  int? enabled;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.content,
      this.publishedAt,
      this.enabled,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    publishedAt = json['published_at'];
    enabled = json['enabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['published_at'] = this.publishedAt;
    data['enabled'] = this.enabled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}