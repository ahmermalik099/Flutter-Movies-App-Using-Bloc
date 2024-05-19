// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../api/api_calls.dart';
// import '../../models/movies_model.dart';
//
// part 'movies_event.dart';
// part 'movies_state.dart';
//
// class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
//   final APIService apiService;
//
//
//   MoviesBloc(this.apiService) : super(MoviesInitial()) {
//     on<MoviesEvent>((event, emit) async {
//       if (event is fetchMovie) {
//         emit(MoviesLoading());
//         try {
//           final movie = await apiService.fetchMovie(event.movieId);
//           emit(MoviesLoaded(movie));
//         } catch (e) {
//           print(e);
//         }
//       }
//
//     });
//   }
// }
//
//
//
//
//
//
//


// lib/bloc/movie_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_api/models/movies_model.dart';

import '../../api/movie_api.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;



  MoviesBloc(this.apiService) : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is FetchMovie) {
        emit(MovieLoading());
        try {
          final movie = await apiService.fetchMovie(event.movieId);
          emit(MovieLoaded(movie));
        } catch (e) {
          emit(MovieError("Failed to fetch movie: $e"));
        }
      } else if (event is FetchAllMovies) { // Add this part for fetching all movies
        emit(MovieLoading());
        try {
          final movies = await apiService.fetchAllMovie();
          emit(AllMovieLoaded(movies));
        } catch (e) {
          emit(MovieError("Failed to fetch all movies: $e"));
        }
      }

    });
  }
}













