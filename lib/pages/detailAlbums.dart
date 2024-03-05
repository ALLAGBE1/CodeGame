import 'package:codegame/pages/albumDetailsPage.dart';
import 'package:codegame/pages/albums.dart';
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
              Row(
                children: [
                  Container(
                    color: Colors.red,
                    width: MediaQuery.sizeOf(context).width / 5,
                    height: MediaQuery.sizeOf(context).height / 8,
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Text('Titre: ${album.title}', style: const TextStyle(fontSize: 18)),
                      Text('ID de l\'utilisateur: ${album.id}', style: const TextStyle(fontSize: 16)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
