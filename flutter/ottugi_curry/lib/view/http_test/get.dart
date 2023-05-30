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

class Bookmark {
  //int? userId;
  int? id;
  String? name;
  String? thumbnail;

  Bookmark({this.id, this.name, this.thumbnail});

  Bookmark.fromJson(Map<String, dynamic> json) {
    //userId = json['userId'];
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['userId'] = this.userId;
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

Future<List<Bookmark>> getData() async {
  const url = 'http://10.0.2.2:8080/api/lately/getLatelyAll?userId=1';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((e) => Bookmark.fromJson(e))
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
  late Future<List<Bookmark>> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bookmark>>(
        future: futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                ...snapshot.data!.map((e) => SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        child: Text(e.thumbnail!),
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
