import 'package:flutter/material.dart';
import 'package:movies_api/screens/profile/storage.dart';
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
    _database = await openDatabase(
      join(await getDatabasesPath(), 'profile_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE profiles(id INTEGER PRIMARY KEY, name TEXT, age TEXT, contact TEXT)",
        );
        print('Database created');
      },
      version: 1,
    );
  }


  Future<void> _insertProfile(String name, String age, String contact) async { //insert function
    await _database.insert(
      'profiles',
      {'name': name, 'age': age, 'contact': contact},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<Map<String, dynamic>> _getProfile() async { //fetch data
    final List<Map<String, dynamic>> profiles = await _database.query('profiles', limit: 1);
    if (profiles.isNotEmpty) {
      return profiles.first;
    } else {
      return {};
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String getName = '';
  String getAge = '';
  String getNo = '';

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
                    },
                    child: Text('Save the Data'),
                  ),
                  SizedBox(height: 20),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
