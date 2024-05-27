import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_api/screens/home/components/card.dart';
import 'package:movies_api/screens/moviesdetails/details_screen.dart';
import 'package:movies_api/bloc/movies/movies_bloc.dart';
import 'package:movies_api/bloc/movies/movies_state.dart';
import 'package:movies_api/bloc/movies/movies_event.dart';
import 'package:movies_api/models/movies_model.dart';

import '../screens/home/home_screen.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  group('MoviePage Widget Tests', () {
    late MoviesBloc moviesBloc;

    setUp(() {
      moviesBloc = MockMoviesBloc();
    });

    testWidgets('should display CircularProgressIndicator when loading',
            (WidgetTester tester) async {
          when(moviesBloc.state).thenReturn(MovieLoading());

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<MoviesBloc>(
                create: (context) => moviesBloc,
                child: MoviePage(),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });

    testWidgets('should display error message when MovieError state',
            (WidgetTester tester) async {
          const errorMessage = 'Failed to fetch movies';
          when(moviesBloc.state).thenReturn(MovieError(errorMessage, errorMessage: ''));

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<MoviesBloc>(
                create: (context) => moviesBloc,
                child: MoviePage(),
              ),
            ),
          );

          expect(find.text('Error: $errorMessage'), findsOneWidget);
        });

    testWidgets('should display list of movies when AllMovieLoaded state',
            (WidgetTester tester) async {
          final movies = [
            Movie(id: 1, title: 'Movie 1', posterPath: '/path1.jpg', adult:false, originalTitle: '', originalLanguage: '', overview: '', popularity: 4334346, voteAverage: 3434, voteCount: 3434),
            Movie(id: 2, title: 'Movie 2', posterPath: '/path2.jpg', adult: true, originalTitle: '', originalLanguage: '', overview: '', popularity: 4334667, voteAverage: 7684, voteCount: 2342),
          ];
          when(moviesBloc.state).thenReturn(AllMovieLoaded(movies));
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<MoviesBloc>(
                create: (context) => moviesBloc,
                child: MoviePage(),
              ),
            ),
          );

          expect(find.byType(MyHomeCard), findsNWidgets(movies.length));
        });
  });
}
