// part of 'movies_bloc.dart';
//
//
//
// sealed class MoviesEvent {
//
//   const MoviesEvent();
//   List<Object> get props => [];
// }
//
// class fetchMovie extends MoviesEvent {
//   final int movieId;
//   const fetchMovie(this.movieId );
//
//   @override
//   List<Object> get props => [];
// }
//
// class SearchMovies extends MoviesEvent {
//   final String query;
//
//   const SearchMovies(this.query);
//
//   @override
//   List<Object> get props => [query];
// }
//
// class FetchMovieDetail extends MoviesEvent {
//   final int movieId;
//
//   const FetchMovieDetail(this.movieId);
//
//   @override
//   List<Object> get props => [movieId];
// }


// lib/bloc/movie_event.dart
import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovie extends MovieEvent {
  final int movieId;

  const FetchMovie(this.movieId);

  @override
  List<Object> get props => [movieId];
}


class FetchAllMovies extends MovieEvent {

  const FetchAllMovies();

  @override
  List<Object> get props => [];
}

