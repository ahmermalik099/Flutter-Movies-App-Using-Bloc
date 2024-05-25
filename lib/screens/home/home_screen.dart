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

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(FetchAllMovies());
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('What do you want to watch?',
            style: TextStyle(color: Colors.black, fontSize: 24)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(400.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              BlocBuilder<MoviesBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    return DetailsScreen(movie: state.movie);
                  } else if (state is MovieError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is AllMovieLoaded) {
                    return Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(movie: movie),
                                ),
                              );
                            },
                            child: MyHomeCard(movie: movie),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                  },
                  ),

          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Now playing'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Top rated'),
              Tab(text: 'Popular'),
            ],

              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildMovieGrid(),
          buildMovieGrid(),
          buildMovieGrid(),
          buildMovieGrid(),
        ],
      )
    );
  }

  Widget buildMovieGrid() {
    return BlocBuilder<MoviesBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          return DetailsScreen(movie: state.movie);
        } else if (state is MovieError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is AllMovieLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 0.7,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie),
                    ),
                  );
                },
                child: MyHomeCard(movie: movie),
              );
            },
          );
        } else {
          return Center(child: Text('No movies found'));
        }
      },
    );
  }
}

