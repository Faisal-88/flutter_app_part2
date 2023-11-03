import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/model/res_berita.dart';
// import 'package:flutter_week_4/model/res_user.dart';
import 'package:flutter_week_4/repository/repo_berita.dart';

class ProvaiderBerita extends ChangeNotifier {
  ProvaiderBerita(){
    getBerita();
  }
  // ProvaiderBerita.initUser() {
  //   getUsers();
  // }
  RepoBerita repo = RepoBerita();
  bool isLoading = false;
  List<Berita> listBerita = [];

  Future<void> getBerita() async {
    try {
      print("hh1");
      isLoading = true;
      notifyListeners();

      ResBerita? res = await repo.getBerita();
      if(res?.isSuccess == true) {
        print("hh2");
        isLoading = false;
        listBerita = res?.data ?? [];
        notifyListeners();
      }
    } catch (e) {
      print("hh3");
      isLoading = false;
      if (kDebugMode) {
        print("Error bloc ${e.toString()}");
      }
      notifyListeners();
    }
  }
}