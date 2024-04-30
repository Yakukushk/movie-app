import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/wishlist.dart';
import 'package:provider/provider.dart';
import '../provider/wishlist_provider.dart';

class Description extends StatelessWidget {
  final String name, description, bannerUrl, posterUrl, vote, launchOn;

  const Description(
      {Key? key,
        required this.name,
        required this.description,
        required this.bannerUrl,
        required this.posterUrl,
        required this.vote,
        required this.launchOn,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = WishListProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.black.withOpacity(0.8),
                      child: modifieldText(
                        text: 'Rating -' + vote,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.all(10),
              child: modifieldText(
                text: name != null ? name : 'Not Loaded',
                size: 24,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 15),
              child: modifieldText(
                text: 'Releasing On - ' + launchOn,
                size: 16,
                color: Colors.white,
              ),
            ),

            Row(
              children: [
                Flexible(
                  child:
                  modifieldText(
                    text: description,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          ElevatedButton(onPressed: (){
                            provider.addMovieToWishlist(Movie(name: name, description: description, bannerUrl: bannerUrl, posterUrl: posterUrl, vote: vote, launchOn: launchOn, id: ''));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text(
                                    "Your Item was added")));
                          },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(15.0), backgroundColor: Colors.red,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.425,
                                  50,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                                )
                              ),
                              child: modifieldText(
                            text: "Add to wishlist",
                            color: Colors.white,
                            size: 18,
                          ))
                        ]
                    )
                )
            ),
          ],
        ),

      ),

    );

  }
}
