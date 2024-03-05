import 'package:codegame/pages/albums.dart';
import 'package:codegame/pages/detailPhoto.dart';
import 'package:flutter/material.dart';

class AlbumDetails extends StatelessWidget {
  final Album album;

  const AlbumDetails({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail Album'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumDetailsPage(albumId: album.id),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Titre: ${album.title}', style: const TextStyle(fontSize: 18)),
              Text('ID de l\'utilisateur: ${album.userId}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
