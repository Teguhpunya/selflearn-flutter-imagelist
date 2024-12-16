import 'package:flutter/material.dart';
import 'package:image_unsplash/model/photo.dart';
import 'package:image_unsplash/service/api.dart';

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
            return GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: s.data!.map((photo) {
                  String downloadUrl = photo.downloadUrl;
                  String previewUrl = downloadUrl.replaceAllMapped(
                      RegExp(r'/id/\d+/\d+/\d+'), (match) => '/id/${match.group(0)!.split('/')[2]}/600/500');
                  return ElevatedButton(
                    onPressed: () {  },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Image.network(previewUrl, width: 600, height: 500, fit: BoxFit.cover,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(photo.author),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
