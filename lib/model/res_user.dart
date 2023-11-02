// To parse this JSON data, do
//
//     final resUser = resUserFromJson(jsonString);

import 'dart:convert';

ResUser resUserFromJson(String str) => ResUser.fromJson(json.decode(str));

String resUserToJson(ResUser data) => json.encode(data.toJson());

class ResUser {
    bool? isSuccess;
    String? message;
    List<User>? data;

    ResUser({
        this.isSuccess,
        this.message,
        this.data,
    });

    factory ResUser.fromJson(Map<String, dynamic> json) => ResUser(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class User {
    String? id;
    String? username;
    String? email;
    String? password;
    String? fullname;
    DateTime? tglDaftar;

    User({
        this.id,
        this.username,
        this.email,
        this.password,
        this.fullname,
        this.tglDaftar,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        tglDaftar: json["tgl_daftar"] == null ? null : DateTime.parse(json["tgl_daftar"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "tgl_daftar": tglDaftar?.toIso8601String(),
    };
}
