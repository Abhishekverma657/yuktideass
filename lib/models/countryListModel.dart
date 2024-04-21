class CountryListModel {
  bool? status;
  String? message;
  Data? data;

  CountryListModel({this.status, this.message, this.data});

  CountryListModel.fromJson(Map<String, dynamic> json) {
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
  String? profileStatus;
  String? role;
  Null? selectedCountry;
  List<Countries>? countries;

  Data({this.profileStatus, this.role, this.selectedCountry, this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    profileStatus = json['profile_status'];
    role = json['role'];
    selectedCountry = json['selected_country'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_status'] = this.profileStatus;
    data['role'] = this.role;
    data['selected_country'] = this.selectedCountry;
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  String? flag;
  String? image;

  Countries({this.id, this.name, this.flag, this.image});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['flag'] = this.flag;
    data['image'] = this.image;
    return data;
  }
}