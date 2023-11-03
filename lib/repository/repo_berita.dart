import 'package:flutter/foundation.dart';
import 'package:flutter_week_4/model/res_berita.dart';
// import 'package:flutter_week_4/model/res_user.dart';
import 'package:http/http.dart' as http;

class RepoBerita {
  Future<ResBerita?> getBerita() async {
    try{
      print("hehe1");
      http.Response res = await http.get(Uri.parse("http://192.168.11.35/htdocs/beritaDb/getBerita.php"));
      return resBeritaFromJson(res.body);
    } catch (e, st) {
      if (kDebugMode) {
        print("Error ${e.toString()}");        
        print("Errorst ${st.toString()}");
      }
    }
  }

  // Future<ResUser?> getUsers(int id) async {
  //   try{
  //     http.Response res = await http.post(
  //       Uri.parse("http://192.168.0.133/beritaDb/getUser.php"),
  //     body: {"id": "$id"});
  //     return resUserFromJson(res.body);
  //   } catch (e, st) {
  //     if (kDebugMode) {
  //       print("Error ${e.toString()}");        
  //       print("Errorst ${st.toString()}");
  //     }
  //   }
  // }
}