import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/sqllite_flutter/alert_add_pegawai.dart';
import 'package:flutter_week_4/sqllite_flutter/db_helper.dart';
import 'model_pegawai.dart';

class ListPegawai extends StatefulWidget {
  const ListPegawai({super.key});

  @override
  State<ListPegawai> createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  DatabaseHelper db = DatabaseHelper();
  List<ModelPegawai> listPegawai = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllPegawai().then((value) {
      setState(() {
        for (var i in value!) {
          listPegawai.add(ModelPegawai.fromMap(i));
          if (kDebugMode) {
            print("dataa $ListPegawai");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Pegawai",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
          itemCount: listPegawai.length,
          itemBuilder: (context, index) {
            ModelPegawai data = listPegawai[index];
            return Card(
              child: ListTile(
                title: Text("${data.firstName} ${data.lastName}"),
                subtitle: Text(data.emailId),
                leading: Text("${data.id}"),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertAddPegawai();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
