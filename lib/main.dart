<<<<<<< HEAD
import 'package:face_punch/AllScreens/loginScreen.dart';
import 'package:face_punch/AllScreens/mainscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
=======
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
>>>>>>> e20c1d8fbf15f25aec22b30abf7fe296264d2575
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Punch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
<<<<<<< HEAD
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
=======
      ),
      home: MyHomePage(title: 'Face Punch'),
>>>>>>> e20c1d8fbf15f25aec22b30abf7fe296264d2575
    );
  }
}

<<<<<<< HEAD
=======
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  int _counter = 0;
  String _name = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: _getImage,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take a picture'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Make API call
                      String apiUrl = 'http://5.75.195.29/api/method/pdms.pdms.api.craete_lead_from_website';
                      http.post(Uri.parse(apiUrl), body: {
                        'name': _name,
                        'image': _image!.path,
                      }).then((response) {
                        // Handle response
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Form Data'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Name: $_name'),
                                    _image == null
                                        ? Text('No image selected.')
                                        : Image.file(_image!),
                                    Text('API response: ${response.body}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
>>>>>>> e20c1d8fbf15f25aec22b30abf7fe296264d2575
