// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_week_4/model/res_berita.dart';
// import 'package:flutter_week_4/model/res_user.dart';
// import 'package:flutter_week_4/repository/repo_berita.dart';
// import 'package:flutter_week_4/provaider_berita/provaider_berita.dart';

// class ProvaiderBerita extends ChangeNotifier {
//   ProvaiderBerita();

//   ProvaiderBerita.initBerita() {
//     getBerita();
//   }
//   ProvaiderBerita.initUser() {
//     getUser();
//   }
//   RepoBerita repo = RepoBerita();
//   bool isLoadingUser = false;
//   List<User> dataUser= [];

//   Future<void> getUser() async {
//     try {
//       isLoadingUser = true;
//       notifyListeners();

//       ResUser? res = await repo.getUsers(1);
//       if(res?.isSuccess == true) {
//         isLoadingUser = false;
//         dataUser = res?.data ?? [];
//         notifyListeners();
//       }
//     } catch (e) {
//       isLoadingUser = false;
//       if (kDebugMode) {
//         print("Error bloc ${e.toString()}");
//       }
//       notifyListeners();
//     }
//   }
// }