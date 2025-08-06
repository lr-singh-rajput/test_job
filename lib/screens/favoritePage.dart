import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteIds = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteIds = prefs.getStringList('favorites') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favoriteIds.isEmpty
          ? Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: favoriteIds.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.favorite, color: Colors.red),
            title: Text("User ID: ${favoriteIds[index]}"),
          );
        },
      ),
    );
  }
}
