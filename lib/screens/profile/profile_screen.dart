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
  String getName = '';
  String getAge = '';
  String getNo = '';

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
                      Storage().writeSecureData('name', nameController.text);
                      Storage().writeSecureData('age', ageController.text);
                      Storage().writeSecureData('contact', contactController.text);

                      print('shhhhhhhhhhhhh');
                      print(nameController.toString());
                      nameController.clear();
                      ageController.clear();
                      contactController.clear();
                    },

                    child: Text('Save the Data'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String? name = await Storage().readSecureData('name');
                      String? age = await Storage().readSecureData('age');
                      String? contact = await Storage().readSecureData('contact');
                      setState(() {
                        getName = name ?? 'No Name Found';
                        getAge = age ?? 'No Age Found';
                        getNo = contact ?? 'No Contact Found';
                      });
                    },
                    child: Text('Show the Data'),
                  ),


                ],
              ),
              // SizedBox(height: 20),
              Text(getName),
              Text('Age: $getAge'),
              Text('Contact: $getNo'),
            ],
          ),
        ),
      ),
    );
  }
}