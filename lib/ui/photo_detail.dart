import 'package:flutter/material.dart';
import 'package:image_unsplash/model/photo.dart';

class PhotoDetail extends StatelessWidget {
  final Photo photo;

  const PhotoDetail({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    String previewUrl = photo.downloadUrl.replaceAllMapped(
        RegExp(r'/id/\d+/\d+/\d+'),
        (match) => '/id/${match.group(0)!.split('/')[2]}/1920/1080');
    return Scaffold(
      body: FutureBuilder(
        future: precacheImage(NetworkImage(previewUrl), context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        // backgroundColor: Colors.transparent,
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          // title: const Text('Photo Detail'),
                          background: Image.network(previewUrl),
                        ),
                      )
                    ],
                body: Column(
                  children: [
                    _PhotoData(photo: photo),
                  ],
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _PhotoData extends StatelessWidget {
  final Photo photo;

  const _PhotoData({required this.photo});

  @override
  Widget build(BuildContext context) {
    List<String> details = [
      "Author: \n${photo.author}",
      "Photo URL: \n${photo.url}"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details
          .map((detail) => SizedBox(
              width: double.infinity,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(detail),
              ))))
          .toList(),
    );
  }
}
