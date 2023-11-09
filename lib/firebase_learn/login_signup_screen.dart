// ignore_for_file: unnecessary_null_comparison, unnecessary_import, avoid_print, constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/firebase_learn/authentication.dart';
import 'package:flutter_week_4/firebase_learn/home_screen.dart';

class LoginSignupPage extends StatefulWidget {
  final BaseAuth? auth;
  final VoidCallback? onLoggedIn;
  final VoidCallback? onSignOut;
  const LoginSignupPage(
    {super.key, this.auth, this.onLoggedIn, this.onSignOut});

    @override
    State<LoginSignupPage> createState() => _LoginSignupPageState();
}

enum FormMode {LOGIN, SIGNUP}

class _LoginSignupPageState extends State<LoginSignupPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? email, password, errorMessage;

  FormMode formMode = FormMode.LOGIN;
  bool? isIos;
  bool isLoading = false;

  bool? validateAndSave() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });
    if (validateAndSave() == true) {
      String? userId = "";
        try{
          if(formMode == FormMode.LOGIN) {
            userId = await widget.auth!.signIn(email ?? "", password ?? "");
            setState((){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false);
                if(kDebugMode) {
                  print("user sign $userId");
                }
            });
          }else {
            userId = await widget.auth!.signUp(email ?? "", password ?? "");
            setState(() {});
            widget.auth!.sendEmailVerification();
            showDialogEmailVerification();
            print("signup id $userId");
            setState(() {
              isLoading = false;
            });
            if (userId!.isNotEmpty &&
            userId != null &&
            formMode == FormMode.LOGIN) {
              widget.onLoggedIn;
              setState(() {});
            }
          }
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
    }
  }

  showDialogEmailVerification() {
    showDialog(context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("Verify your Account"),
        content: const Text(
          "Link to verify account has bean sent to your email"),
          actions: [
            TextButton(
              onPressed: () {
                chengeFormLogin();
                Navigator.pop(context);
              },
              child: const Text("Dissmis"))
          ],
      );
    });
  }

  void chengeFormLogin() {
    key.currentState!.reset();
    errorMessage = "";
    setState(() {
      formMode = FormMode.LOGIN;
    });
  }

  void chengeFormSignUp() {
    key.currentState!.reset();
    errorMessage = "";
    setState(() {
      formMode = FormMode.SIGNUP;
    });
  }

  void iniState() {
    // TODO: implement iniState
    super.initState();
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 7, 0, 0),
                  child: CircleAvatar(
                    radius: 48,
                    child: Image.network("https://img-b.udemycdn.com/user/200_H/67132062_59c2.jpg"),
                  ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    validator: (val) {
                      return val!.isEmpty ? "Email can/'t be Empty" : null;
                    },
                      onSaved: (val) {
                        email = val;
                      },
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      icon: Icon(
                        Icons.email,
                        color: Colors.green,
                        )),
                  ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Password can/'t be Empty" : null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  autofocus: false,
                  onSaved: (val) {
                    password = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.green,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
               child: MaterialButton(
                  elevation: 5,
                  color: Colors.green,
                  minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 45,
                onPressed: () {
                  validateAndSubmit();
                },
                child: formMode == FormMode.LOGIN
                    ? const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                    : const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                 ),
                ),
                 TextButton(
                  onPressed: () {
                    if (formMode == FormMode.LOGIN) {
                      chengeFormSignUp();
                    }else {
                      chengeFormLogin();
                    }
                  },
                  child: formMode == FormMode.LOGIN
                    ? const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                    )
                    : const Text(
                      "Have an account? Plase Sign in",
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );     
  }
}