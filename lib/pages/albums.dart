import 'dart:convert';

import 'package:codegame/pages/detailAlbums.dart';
import 'package:codegame/widgets/cg_listTile.dart';
import 'package:codegame/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Albums extends StatefulWidget {
  const Albums({Key? key}) : super(key: key);

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Album> albums = jsonResponse.map((data) => Album.fromJson(data)).toList();

      for (var album in albums) {
        final photosResponse =
            await http.get(Uri.parse('https://jsonplaceholder.typicode.com/album/${album.id}/photos'));
        if (photosResponse.statusCode == 200) {
          List photosJson = json.decode(photosResponse.body);
          album.setPhotos = photosJson.map((photo) => Photo.fromJson(photo)).toList();
        }
      }

      return albums;
    } else {
      throw Exception('Erreur lors du chargement des albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: FutureBuilder<List<Album>>(
        future: fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${snapshot.error}"),
                  action: SnackBarAction(
                    label: 'Réessayer',
                    onPressed: () {
                      setState(() {
                        fetchAlbums();
                      });
                    },
                  ),
                ),
              );
            });
            return const Center(child: Loader());
          }

          return const Center(child: Loader());
        },
      ),
    );
  }
}

class Album {
  final int id;
  final int userId;
  final String title;
  List<Photo> photos;

  Album({required this.id, required this.userId, required this.title, required this.photos});

  set setPhotos(List<Photo> value) {
    photos = value;
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      photos: [],
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String url;
  final int albumId;

  Photo({required this.id, required this.title, required this.url, required this.albumId});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      albumId: json['albumId'],
    );
  }
}
