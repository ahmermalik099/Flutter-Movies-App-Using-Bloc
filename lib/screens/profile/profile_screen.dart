import 'package:flutter/material.dart';
import 'package:movies_api/screens/profile/storage.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String inputText = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile '),
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
                    onPressed: (){
                      Storage().writeSecureData('name', inputText);
                      Storage().writeSecureData('age', inputText);
                      Storage().writeSecureData('contact', inputText);
                    },

                    child: Text('Save the Data'),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}