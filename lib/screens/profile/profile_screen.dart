import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    print('inside _initializeDatabase');
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'profile_database.db');
      _database = await openDatabase(
        path,
        onCreate: (db, version) async {
          print('Creating database at $path');
          await db.execute(
            "CREATE TABLE profiles(id INTEGER PRIMARY KEY, name TEXT, age TEXT, contact TEXT)",
          );
          print('Database created');
        },
        version: 1,
      );
      print('Database initialized');
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  Future<void> _insertProfile(String name, String age, String contact) async {
    try {
      await _database.insert(
        'profiles',
        {'name': name, 'age': age, 'contact': contact},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Profile inserted: $name, $age, $contact');
    } catch (e) {
      print('Error inserting profile: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _getAllProfiles() async {
    try {
      return await _database.query('profiles');
    } catch (e) {
      print('Error fetching profiles: $e');
      return [];
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter Your Name',
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  icon: Icon(Icons.send_time_extension_rounded),
                  hintText: 'Enter Your Age',
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter Your Contact Number',
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      await _insertProfile(
                        nameController.text,
                        ageController.text,
                        contactController.text,
                      );
                      nameController.clear();
                      ageController.clear();
                      contactController.clear();
                      print('Data Saved');
                      setState(() {}); // Trigger a rebuild to refresh the list
                    },
                    child: Text('Save the Data'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _initializeDatabase,
                    child: Text('Connect Database'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _getAllProfiles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No profiles found.');
                    } else {
                      final profiles = snapshot.data!;
                      return ListView.builder(
                        itemCount: profiles.length,
                        itemBuilder: (context, index) {
                          final profile = profiles[index];
                          return ListTile(
                            title: Text(profile['name']),
                            subtitle: Text('Age: ${profile['age']}, Contact: ${profile['contact']}'),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
