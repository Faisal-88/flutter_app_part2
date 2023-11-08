import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/firebase_learn/authentication.dart';

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
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (_) => HomePage()),
              //   (route) => false);
              //   if(kDebugMode) {
              //     print("user sign $userId");
              //   }
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

  @override
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
                    child: Image.network(""),
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
                    return val!.isEmpty ? "Password can\'t be Empty" : null;
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
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );     
  }
}