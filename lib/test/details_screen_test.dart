import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_api/models/movies_model.dart';
import 'package:movies_api/screens/moviesdetails/details_screen.dart';

void main() {
  final movie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'This is a test movie',
    posterPath: '/test.jpg',
    releaseDate: '2023-01-01',
    popularity: 100.0,
    adult: false, originalTitle: '', originalLanguage: '', voteAverage: 0, voteCount: 0, backdropPath: '',
  );

  testWidgets('DetailsScreen displays movie details', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DetailsScreen(movie: movie),
    ));

    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.text('This is a test movie'), findsOneWidget);
    expect(find.text('Release Date: 2023-01-01'), findsOneWidget);
    expect(find.text('Popularity: 100.0'), findsOneWidget);
    expect(find.text('Adult: No'), findsOneWidget);
  });

  testWidgets('DetailsScreen switches tab to Trailer', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DetailsScreen(movie: movie),
    ));

    expect(find.text('About Movie'), findsOneWidget);
    expect(find.text('Trailer'), findsOneWidget);

    // Switch to Trailer tab
    await tester.tap(find.text('Trailer'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.play_circle_outline), findsOneWidget);
  });

  testWidgets('DetailsScreen back button navigates back', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => DetailsScreen(movie: movie),
        ),
      ),
    ));

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(DetailsScreen), findsNothing);
  });
}
