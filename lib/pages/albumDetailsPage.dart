import 'dart:convert';

import 'package:codegame/pages/albums.dart';
import 'package:codegame/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumDetailsPage extends StatefulWidget {
  final int albumId;

  const AlbumDetailsPage({Key? key, required this.albumId}) : super(key: key);

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  Album? album;

  @override
  void initState() {
    super.initState();
    fetchAlbumDetails();
  }

  Future<void> fetchAlbumDetails() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/${widget.albumId}'));

    if (response.statusCode == 200) {
      setState(() {
        album = Album.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Erreur lors du chargement des détails de l\'album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: album == null ? const Text('Chargement...') : Text('${album!.id}'),
      ),
      body: album == null
          ? const Center(child: Loader())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Titre: ${album!.title}', style: const TextStyle(fontSize: 18)),
                    Text('ID de l\'utilisateur: ${album!.id}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.green,
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: MediaQuery.sizeOf(context).height / 5,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
