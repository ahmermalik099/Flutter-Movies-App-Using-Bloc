import 'package:flutter/material.dart';
import 'package:movies_api/models/movies_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                  child: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  height: 600,
              ),
              Text(movie!.title, style: TextStyle(fontSize: 24)),
              SizedBox(height: 10),
              Text(movie!.overview),
              SizedBox(height: 10),
              Text('Adult: ${movie!.adult}'),
              SizedBox(height: 10),
              Text('Release Date: ${movie.releaseDate}'),
              SizedBox(height: 10),
              Text('Popularity : ${movie.popularity}'),
            ],
          ),
        ),
      ),
    );
  }
}
