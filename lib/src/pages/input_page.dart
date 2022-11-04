import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  String name = '';
  String genre = '';
  int? year;
  String? image;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Yangi kino qo`shish"),
            centerTitle: true,
            elevation: 0.2),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty && value == null) {
                      return "To`ldirilmagan";
                    }
                  },
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Genre',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty && value == null) {
                      return "To`ldirilmagan";
                    }
                  },
                  onSaved: (newValue) {
                    genre = newValue!;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Year',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty && value == null) {
                      return "To`ldirilmagan";
                    }
                  },
                  onSaved: (newValue) {
                    year = num.parse(newValue!).toInt();
                  },
                  keyboardType: TextInputType.datetime,
                ),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueGrey),
                      shadowColor: MaterialStatePropertyAll(Colors.white70)),
                  onPressed: () async {
                    pickImage().then((value) async => await _saveToStorage());
                  },
                  child: const Text(
                    "Upload Image",
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: () {
                    _addMovie(context);
                  },
                  child: Text("add")),
              if (isLoading != false)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  void _addMovie(context) {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      __createMovie(context);
    }
  }

  void __createMovie(context) async {
    await _saveToStorage();
    CollectionReference movie = FirebaseFirestore.instance.collection("movies");
    try {
      await movie.doc(name.replaceAll(" ", "_")).set({
        "name": name,
        "genre": genre,
        "year": year,
        "image": image,
      }, SetOptions(merge: true));
      Navigator.pop(context);
    } catch (e) {
      debugPrint("----------->$e");
      print("------------> $e");
    }
  }

  File? _selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _selectedImage = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _saveToStorage() async {
    setState(() {
      isLoading = true;
    });
    final storageRef = FirebaseStorage.instance.ref();
    try {
      final upLoadImage = await storageRef
          .child("posters")
          .child(name
            ..replaceAll(' ', "_")
            ..toString())
          .putFile(_selectedImage!);

      image = await upLoadImage.ref.getDownloadURL();

      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      debugPrint("");
    }
  }
}
