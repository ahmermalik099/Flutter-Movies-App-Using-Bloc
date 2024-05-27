// part of 'movies_bloc.dart';
//
//
//
// sealed class MoviesState {
//   const MoviesState();
//   List<Object> get props => [];
// }
//
// final class MoviesInitial extends MoviesState {
//
// }
//
// final class MoviesLoading extends MoviesState {
//
// }
//
// final class MoviesLoaded extends MoviesState {
// final Movie movies;
// const MoviesLoaded(this.movies);
//
// @override
// List<Object> get props => [movies];
// }


// lib/bloc/movie_state.dart
import 'package:equatable/equatable.dart';

import '../../models/movies_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final Movie movie;

  const MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}


class AllMovieLoaded extends MovieState {
  final List<Movie> movies;

   AllMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message, {required String errorMessage});

  @override
  List<Object> get props => [message];
}
