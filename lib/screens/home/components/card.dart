import 'package:flutter/material.dart';

import '../../../models/movies_model.dart';


class MyHomeCard extends StatelessWidget {
  //const MyHomeCar({Key? key}) : super(key: key);

  MyHomeCard({
    super.key,
    this.movie,
});

  final Movie? movie;
  String poster='https://image.tmdb.org/t/p/w500';


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 4.5,
      margin: EdgeInsets.only(bottom: 3, right: 4, top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 241, 231, 231).withOpacity(.05),
              blurRadius: 5,
              spreadRadius: 5)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            movie?.posterPath == null ||
                    movie?.posterPath == ""
                ? Image.asset(
                    'assets/bg.jpeg',
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: 'assets/bg.jpeg',
                    image: 'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
                    fit: BoxFit.fitHeight,
                  ),

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie?.title ?? 'NULL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   movie?.overview ?? 'NULL',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
