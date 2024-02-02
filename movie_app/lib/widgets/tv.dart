import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

class TopTVShow extends StatelessWidget {
  final List tvShow;

  const TopTVShow({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modifieldText(
            text: 'Popular TV Shows',
            size: 26,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvShow.length,
              itemBuilder: (context, index) {

                final backdropPath = tvShow[index]['backdrop_path'];
                final imageUrl = backdropPath != null && backdropPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500$backdropPath'
                    : 'https://via.placeholder.com/500';

                return Container(
                  padding: EdgeInsets.all(5),
                  width: 250,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 140,
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: modifieldText(
                          size: 15,
                          text: tvShow[index]['original_name'] ?? 'Loading',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
