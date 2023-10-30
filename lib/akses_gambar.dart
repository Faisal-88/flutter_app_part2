import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AkesGambar extends StatefulWidget {
  const AkesGambar({super.key});

  @override
  State<AkesGambar> createState() => _AkesGambarState();
}

class _AkesGambarState extends State<AkesGambar> {
  XFile? image;

  Future<void> getFromKamera() async {
    var res = await ImagePicker().pickImage(source: ImageSource.camera); //bisa gunakan fitur "camera" atau ("galleri" <-untuk input foto)
    if(res != null) {
      setState(() {
        image = res;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Akeses Gambar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: image != null
        ? Center(
          child: Image.file(
            File(image!.path),
            width: 250,
            height: 350,
          ),
        )
        : const Center(child: Text("Silahkan pilih gambar")),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
              await getFromKamera();
          },
          child: const Icon(
            Icons.photo,
            color: Colors.green,
          ),
        ),
    );
  }
}