import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_list_model.dart';

class UserController {
  final String apiUrl = "https://reqres.in/api/users?page=2"; 

  Future<UserListModel> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
     
        return UserListModel.fromJson(json.decode(response.body));
      } else {

        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {

      throw Exception('Failed to load users: $e');
    }
  }


}








