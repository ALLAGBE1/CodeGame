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
      body: ListView.builder(
        itemCount: album.photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailsPage(albumId: album.id),
                ),
              );
            },
            child: ListTile(
              leading: Image.network(album.photos[index].url),
              title: Text(album.photos[index].title),
            ),
          );
        },
      ),
    );
  }
}
