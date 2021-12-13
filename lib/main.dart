import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Camera Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? _imageFile;
  dynamic _pickImageError;

  void _onImageButtonPressed(ImageSource source) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: source);
      _imageFile = File(pickedImage!.path);
      setState((){});
    } catch (e) {
      _pickImageError = e;
    }
  }

  Widget _displayImage() {
    if(_imageFile != null) {
      return Image.file(_imageFile!);
    } else if (_pickImageError != null) {
      return Text(
        'Error getting image: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'No image',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _displayImage(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery);
              },
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera);
              },
              child: const Icon(Icons.photo_camera),
            ),
          ),
        ],
      ),
    );
  }
}