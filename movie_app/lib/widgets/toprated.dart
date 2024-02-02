import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/description.dart';
class TopRateMovies extends StatelessWidget {
  final List topRate;

  const TopRateMovies({Key? key, required this.topRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modifieldText(
              text: "Top Rated", color: Colors.white, size: 26,),
            SizedBox(height: 10,),
            Container(
                height: 280,
                child: ListView.builder(
                    itemCount: topRate.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                    name: topRate[index]['title'],
                                    bannerUrl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        topRate[index]['backdrop_path'],
                                    posterUrl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        topRate[index]['poster_path'],
                                    description: topRate[index]['overview'],
                                    vote: topRate[index]['vote_average']
                                        .toString(),
                                    launchOn: topRate[index]
                                    ['release_date'],

                                  )));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                topRate[index]['poster_path']),
                                      ))),
                              Container(
                                child: modifieldText(
                                    color: Colors.white,
                                    size: 16,
                                    text: topRate[index]['title'] != null
                                        ? topRate[index]['title']
                                        : 'Loading...'),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ));
  }
}
