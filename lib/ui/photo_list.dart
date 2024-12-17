import 'package:flutter/material.dart';
import 'package:image_unsplash/model/photo.dart';
import 'package:image_unsplash/service/api.dart';
import 'package:image_unsplash/ui/photo_detail.dart';

class BrowsePhotos extends StatelessWidget {
  const BrowsePhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhotoTiles();
  }
}

class PhotoTiles extends StatefulWidget {
  const PhotoTiles({super.key});

  @override
  State<PhotoTiles> createState() => _PhotoTilesState();
}

class _PhotoTilesState extends State<PhotoTiles> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    setState(() {
      futurePhotos = API.getRandomPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futurePhotos,
        builder: (c, s) {
          if (s.hasError) {
            return Center(child: Text('${s.error}'));
          } else if (s.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: s.data!.map((photo) {
                    String downloadUrl = photo.downloadUrl;
                    String previewUrl = downloadUrl.replaceAllMapped(
                        RegExp(r'/id/\d+/\d+/\d+'), (match) => '/id/${match.group(0)!.split('/')[2]}/500/500');
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhotoDetail(photo: photo)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Image.network(previewUrl),
                    );
                  }).toList()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
