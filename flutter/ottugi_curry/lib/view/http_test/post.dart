import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipeWidget(),
    );
  }
}

class Recipe {
  //int? userId;
  int? id;
  String? composition;
  String? difficulty;
  String? ingredients;
  String? name;
  String? thumbnail;
  String? time;
  bool? isBookmark;

  Recipe({this.id, this.name, this.thumbnail});

  Recipe.fromJson(Map<String, dynamic> json) {
    //userId = json['userId'];
    id = json['id'];
    composition = json['composition'];
    difficulty = json['difficulty'];
    ingredients = json['ingredients'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    time = json['time'];
    isBookmark = json['isBookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['userId'] = this.userId;
    data['id'] = id;
    data['composition'] = composition;
    data['difficulty'] = difficulty;
    data['ingredients'] = ingredients;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['time'] = time;
    data['isBookmark'] = isBookmark;

    return data;
  }
}

Future<List<Recipe>> postData() async {
  var url = Uri.parse('http://192.168.219.109:8080/api/recipe/getRecipeList');
  var data = {
    "userId": 1,
    "recipeId": [6855278, 6909678]
  };

  http.Response response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data) //json.encode(['6855278', '6909678']
      );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((e) => Recipe.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class RecipeWidget extends StatefulWidget {
  const RecipeWidget({Key? key}) : super(key: key);

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  late Future<List<Recipe>> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = postData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
        future: futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                ...snapshot.data!.map((e) => SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Card(
                            elevation: 4,
                            child: Text(e.thumbnail!),
                          ),
                          Card(
                            elevation: 4,
                            child: Text(e.name!),
                          ),
                        ],
                      ),
                    )),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }
          return const CircularProgressIndicator();
        });
  }
}
