import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/firebase_learn/add_food_firebase.dart';
import 'package:flutter_week_4/firebase_learn/authentication.dart';
import 'package:flutter_week_4/firebase_learn/res_food.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final BaseAuth? auth;
  final VoidCallback? onSignOut;
  const HomePage({super.key, this.userId, this.auth, this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;
  List<ResFood> listFood = [];
  Query? queryFood;
  StreamSubscription<DatabaseEvent>? onAddList;

  Future<void> getData() async {
    queryFood = database.ref().child("kuliner").orderByChild("userId").equalTo(widget.userId);
    onAddList = queryFood?.onChildAdded.listen(updateList); 
  }

  Future<void> updateList(DatabaseEvent event) async {
    setState(() {
      listFood.add(ResFood.fromSnapshoot(event.snapshot));
    });
  }

  @override
  void initState() {
    // TODO: implement iniState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onAddList?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food App",
          style: TextStyle(color: Colors.white)
          ),
        backgroundColor: Colors.green,
      ),
      body: listFood.isEmpty
            ? const Center(
              child: Text("Belum ada data"),
            )
            : ListView.builder(
            itemCount: listFood.length,
            itemBuilder: (context, index) {
              ResFood data = listFood[index];
              return ListTile(
                title: Text("${data.namaMakanan}"),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return addFoodFirebase(
                userId: widget.userId
              );
            });
          },
          child: const Icon(
            Icons.add
          ),
        ),
    );
  }
}