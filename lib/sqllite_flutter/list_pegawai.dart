import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/sqllite_flutter/alert_add_pegawai.dart';
import 'package:flutter_week_4/sqllite_flutter/db_helper.dart';
import 'package:flutter_week_4/sqllite_flutter/edit_pegawai.dart';
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Anda yakin akan menghapus data atas nama ${data.firstName} ${data.lastName} ?",
                            style: const TextStyle(fontSize: 12),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            child: const Text("Cencel"),
                            ),
                            TextButton(
                              onPressed: () {
                                db.deletePegawai(data.id)
                                .then((value) {
                                  setState(() {
                                    listPegawai.remove(data);
                                  });
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const ListPegawai()),
                                    (route) => false,
                                    );
                                });
                              },
                              child: const Text("OK"))
                          ],
                        );
                      });
                  },
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditPegawai(data)));
                  },
                  child: const Icon(Icons.edit)),
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
