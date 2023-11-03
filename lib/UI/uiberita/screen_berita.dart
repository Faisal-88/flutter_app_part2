import 'package:flutter/material.dart';
import 'package:flutter_week_4/UI/uiberita/screen_user.dart';
import 'package:flutter_week_4/model/res_berita.dart';
import 'package:flutter_week_4/provaider_berita/provaider_berita.dart';
import 'package:provider/provider.dart';

class ScreenBerita extends StatelessWidget {
  const ScreenBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
      return ProvaiderBerita();
      },
   child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Berita",
          style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Navigator.push(context,
          //        MaterialPageRoute(builder: (_) =>  const ScreenUser()));
          //     },
          //     icon: const Icon(Icons.person))
          // ],
      ),
      body: Consumer<ProvaiderBerita>(
        builder: (BuildContext context, value, Widget? child) {
          return value.isLoading == true
          ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ) 
          : ListView.builder(
            itemCount: value.listBerita.length,
            itemBuilder: (context, index) {
              Berita data = value.listBerita[index];
              return ListTile(
                title: Text("${data.judul}"),
              );
            });
        },
      ),
    ),
    );
  }
}