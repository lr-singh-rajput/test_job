
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/dataController.dart';
import '../model/userModel.dart';
import '../model/user_list_model.dart';
import 'favoritePage.dart';
    

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<UserListModel> futureUsers;
  List<int> favoriteIds = [];
  @override
  void initState() {
    super.initState();
    futureUsers = UserController().fetchUsers();
    loadFavorites();
  }
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteIds = prefs.getStringList('favorites')?.map((e) => int.parse(e)).toList() ?? [];
    });
  }

  void toggleFavorite(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favoriteIds.contains(userId)) {
      favoriteIds.remove(userId);
    } else {
      favoriteIds.add(userId);
    }
    await prefs.setStringList('favorites', favoriteIds.map((e) => e.toString()).toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Lst"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>FavoritePage()));
            },
          ),
        ],
      ),
      body: FutureBuilder<UserListModel>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No data available"));
          } else {
            UserListModel userList = snapshot.data!;
            return ListView.builder(
              itemCount: userList.data.length,
              itemBuilder: (context, index) {
                User user = userList.data[index];
                bool isFavorite = favoriteIds.contains(user.id);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 80,width: 80,
                        child: Image.network(user.avatar,fit: BoxFit.cover,)
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${user.firstName} ${user.lastName}"),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () => toggleFavorite(user.id),
                        )
                      ],
                    ),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}



