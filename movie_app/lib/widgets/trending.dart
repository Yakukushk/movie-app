import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modifieldText(
                text: "Trending Movies", color: Colors.white, size: 26,),
            SizedBox(height: 10,),
            Container(
                height: 270,
                child: ListView.builder(
                    itemCount: trending.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                    name: trending[index]['title'],
                                    bannerUrl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        trending[index]['backdrop_path'],
                                    posterUrl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        trending[index]['poster_path'],
                                    description: trending[index]['overview'],
                                    vote: trending[index]['vote_average']
                                        .toString(),
                                    launchOn: trending[index]
                                    ['release_date'],
                                  )));
                        },
                        child: trending[index]['title']!=null?Container(
                          width: 150,
                          child: Column(
                            children: [
                              Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path']),
                                  ))),
                              Container(
                                child: modifieldText(
                                    color: Colors.white,
                                    size: 18,
                                    text: trending[index]['title']

                                        ),
                              )
                            ],
                          ),
                        ):Container(),
                      );
                    }))
          ],
        ));
  }
}
