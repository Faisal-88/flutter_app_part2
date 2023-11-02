import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/model/res_berita.dart';
import 'package:flutter_week_4/model/res_user.dart';
import 'package:flutter_week_4/repository/repo_berita.dart';

class ProvaiderBerita extends ChangeNotifier {
  ProvaiderBerita();

  ProvaiderBerita.initBerita() {
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
      isLoading = true;
      notifyListeners();

      ResBerita? res = await repo.getBerita();
      if(res?.isSuccess == true) {
        isLoading = false;
        listBerita = res?.data ?? [];
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      if (kDebugMode) {
        print("Error bloc ${e.toString()}");
      }
      notifyListeners();
    }
  }
}