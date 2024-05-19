// // lib/movie_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../bloc/movies/movies_bloc.dart';
// import '../../models/movies_model.dart';
//
//
// class MoviePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             BlocBuilder<MoviesBloc, MoviesState>(
//               builder: (context, state) {
//                 if (state is MoviesInitial) {
//                   return Text('Enter a movie ID');
//                 } else if (state is MoviesLoading) {
//                   return CircularProgressIndicator();
//                 } else if (state is MoviesLoaded) {
//                   return MovieDetail(movie: state.movies);
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<MoviesBloc>().add(fetchMovie(157336)); // Example movie ID
//               },
//               child: Text('Fetch Movie'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MovieDetail extends StatelessWidget {
//   final Movie movie;
//
//   const MovieDetail({Key? key, required this.movie}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Text(movie.title, style: TextStyle(fontSize: 24)),
//         SizedBox(height: 10),
//         Text(movie.overview),
//         SizedBox(height: 10),
//         Text('Release Date: ${movie.releaseDate}'),
//         SizedBox(height: 10),
//         Text('Rating: ${movie.voteAverage}'),
//       ],
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_api/screens/home/components/card.dart';

import '../../bloc/movies/movies_bloc.dart';
import '../../bloc/movies/movies_event.dart';
import '../../bloc/movies/movies_state.dart';
import '../../models/movies_model.dart';
import '../moviesdetails/details_screen.dart';

class MoviePage extends StatefulWidget {


  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(FetchAllMovies());
  }
  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<MoviesBloc, MovieState>(
                builder: (context, state) {
                   if (state is MovieLoading) {
                    return CircularProgressIndicator();
                  } else if (state is MovieLoaded) {
                    return MovieDetail(movie: state.movie);
                  } else if (state is MovieError) {
                    return Text('Error: ${state.message}');

                  }
                  else if(state is AllMovieLoaded){
                    return Column(
                      children: state.movies.map((movie) => MovieDetail(movie: movie)).toList(),
                    );
                  }
                  else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  movieBloc.add(FetchAllMovies()); // Example movie ID
                },
                child: Text('Fetch Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.1,
      color: Colors.white,
      child: GridView.builder(

        shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 0.7,
          ),
          itemCount: 2,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie,)));
              },
              child: MyHomeCard(movie: movie)
            );
          }
      ),
    );
  }
}

