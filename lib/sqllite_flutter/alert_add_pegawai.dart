
import 'package:flutter/material.dart';
import 'package:flutter_week_4/sqllite_flutter/db_helper.dart';
import 'package:flutter_week_4/sqllite_flutter/list_pegawai.dart';
import 'package:flutter_week_4/sqllite_flutter/model_pegawai.dart'; 


class AlertAddPegawai extends StatefulWidget {
    const AlertAddPegawai ({super.key});

@override
State<AlertAddPegawai> createState() => _AlertAddPegawaiState();
}

class _AlertAddPegawaiState extends State<AlertAddPegawai> { 
    TextEditingController firstName = TextEditingController(); 
    TextEditingController lastName = TextEditingController(); 
    TextEditingController mobileNo = TextEditingController();
    TextEditingController email = TextEditingController();
    GlobalKey<FormState> key = GlobalKey<FormState>();
    DatabaseHelper db = DatabaseHelper();

@override
Widget build (BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
            scrollable: true,
            title: const Center (child: Text ("Add Pegawai")),
        content: Center(
            child: SizedBox(
                width: MediaQuery.of (context).size.width,
                child: Form(
                    key: key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                            TextFormField(
                                validator: (val) {
                                    return val!.isEmpty? "required" : null;
                                },
                                controller: firstName,
                                decoration: const InputDecoration(hintText: "FIRSTNAME"),
                            ),
                            const SizedBox(
                                height: 8,
                            ),
                            TextFormField(
                                validator: (val) {
                                    return val!.isEmpty? "required": null;
                                },
                                controller: lastName,
                                decoration: const InputDecoration (hintText: "LASTANAME"),
                                ),
                            const SizedBox(
                                height: 8,
                            ),
                            TextFormField(
                                validator: (val) {
                                    return val!.isEmpty? "required": null;
                                },
                                controller: mobileNo,
                                decoration: const InputDecoration (hintText: "Mobile No"),
                            ),
                            const SizedBox(
                                height: 8,
                            ),
                            TextFormField(
                                validator: (val) {
                                    return val!.isEmpty ? "required": null;
                                },
                            controller: email,
                            decoration: const InputDecoration(hintText: "EMAIL"),
                            ),
                            const SizedBox(
                                height: 25,
                            ), 
                            Center(
                                child: MaterialButton(
                                    height: 45,
                                    minWidth: 200,
                                    onPressed: () {
                                        if (key.currentState!.validate()) {
                                            db
                                                .saveData(ModelPegawai(firstName.text,
                                                    lastName.text, mobileNo.text, email.text))
                                                    .then((value) {
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => const ListPegawai()), 
                                                            (route) => false);
                                                    });
                                                }
                                            },
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            child: const Text("SIMPAN"),
                                        ),
                                    )
                                  ], 
                                ),
                              ),
                            ),
                          ),
                        );
    }
}