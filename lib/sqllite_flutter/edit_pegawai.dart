import 'package:flutter/material.dart';
import 'package:flutter_week_4/sqllite_flutter/db_helper.dart';
import 'package:flutter_week_4/sqllite_flutter/list_pegawai.dart';
import 'package:flutter_week_4/sqllite_flutter/model_pegawai.dart';

class EditPegawai extends StatefulWidget {
  final ModelPegawai data;
  const EditPegawai(this.data, {super.key});

  @override
  State<EditPegawai> createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  TextEditingController? firstName, lastName, mobileNo, emailId;
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = TextEditingController(text: widget.data.firstName);
    lastName = TextEditingController(text: widget.data.lastName);
    mobileNo = TextEditingController(text: widget.data.mobileNo);
    emailId = TextEditingController(text: widget.data.emailId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Pegawai",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextFormField(
                controller: firstName,
                decoration: const InputDecoration(hintText: "FIRSTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lastName,
                decoration: const InputDecoration(hintText: "LASTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: mobileNo,
                decoration: const InputDecoration(hintText: "MOBILE PHONE"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: emailId,
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
                    db
                        .updatePegawai(ModelPegawai.fromMap({
                      "id": widget.data.id,
                      "firstname": firstName?.text,
                      "lastname": lastName?.text,
                      "mobileno": mobileNo?.text,
                      "emailid": emailId?.text
                    }))
                        .then((__) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ListPegawai()),
                          (route) => false);
                    });
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text("UPDATE"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
