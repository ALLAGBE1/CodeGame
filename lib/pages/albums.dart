// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:codegame/pages/detailAlbums.dart';
import 'package:codegame/widgets/cg_listTile.dart';
import 'package:codegame/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Albums extends StatefulWidget {
  const Albums({super.key});

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Album.fromJson(data)).toList();
    } else {
      throw Exception('Erreur lors du chargement des albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: FutureBuilder<List<Album>>(
        future: fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetails(album: snapshot.data![index]),
                        ),
                      );
                    },
                    child: CGListTile(
                      labelText: snapshot.data![index].title,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: Loader());
        },
      ),
    );
  }
}

class Album {
  final int id;
  final int userId;
  final String title;

  Album({required this.id, required this.userId, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
}
