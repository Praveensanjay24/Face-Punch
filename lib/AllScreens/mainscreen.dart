import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:face_detection/face_detection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0;
  String _name = '';

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future detectFace() async {
    final response = await http.post(
      Uri.parse('https://api.imagga.com/v2/faces/detections'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('api_key:api_secret'))}',
      },
      body: <String, dynamic>{
        'image_base64': base64Encode(_image!.readAsBytesSync()),
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> faces = jsonResponse['result']['faces'];
      if (faces.isNotEmpty) {
        Map<String, dynamic> face = faces[0];
        Map<String, dynamic> attributes = face['attributes'];
        String gender = attributes['gender']['value'];
        String age = attributes['age']['value'].toString();
        String ethnicity = attributes['ethnicity']['value'];
        String emotion = attributes['emotion']['value'];

        setState(() {
          _name = '$gender, $age, $ethnicity, $emotion';
        });
      } else {
        setState(() {
          _name = 'No face detected';
        });
      }
    } else {
      setState(() {
        _name = 'Error detecting face';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Punch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(
              _image!,
              height: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image == null ? null : detectFace,
              child: Text('Detect Face'),
            ),
            SizedBox(height: 20),
            Text(
              '$_name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'You have pushed the button $_counter times.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
