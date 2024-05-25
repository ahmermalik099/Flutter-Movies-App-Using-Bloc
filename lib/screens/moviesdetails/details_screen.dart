import 'package:flutter/material.dart';
import 'package:movies_api/models/movies_model.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(child: Text(
            'Detail',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
        )
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 0, left: 14, right: 14),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 20),
                Row(
                    children:[
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Release Date: ${widget.movie.releaseDate}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Popularity: ${widget.movie.popularity}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.info, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Adult: ${widget.movie.adult ? "Yes" : "No"}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ]
                ),
                SizedBox(height: 40,),// Space for the AppBar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_selectedTabIndex == 0) ...[
                        Text(
                          widget.movie.title,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        //SizedBox(height: 10),

                        SizedBox(height: 10),
                        Text(
                          widget.movie.overview,
                          style: TextStyle(fontSize: 16),
                        ),
                      ] else ...[
                        Center(
                          child: IconButton(
                            iconSize: 100,
                            icon: Icon(Icons.play_circle_outline),
                            onPressed: () {
                              // Handle play trailer action
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 450,
            left: 0,
            right: 0,
            child: Column(
              children: [

                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _onTabSelected(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "About Movie",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: _selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                                color: _selectedTabIndex == 0 ? Colors.white : Colors.white70,
                              ),
                            ),
                            if (_selectedTabIndex == 0)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 60,
                                color: Colors.white,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onTabSelected(1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Trailer",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: _selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                                color: _selectedTabIndex == 1 ? Colors.white : Colors.white70,
                              ),
                            ),
                            if (_selectedTabIndex == 1)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 60,
                                color: Colors.white,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
