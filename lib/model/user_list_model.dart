import 'package:jobtest/model/userModel.dart';

class UserListModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<User> data;

  UserListModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: List<User>.from(json['data'].map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}
