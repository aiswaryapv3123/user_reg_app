import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_reg_app/src/screens/home_page.dart';
import 'package:user_reg_app/src/screens/registration_page.dart';
import 'package:user_reg_app/src/utils/utils.dart';
import 'package:user_reg_app/src/widgets/build_button.dart';
import 'package:user_reg_app/src/widgets/user_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth(context, dividedBy: 1),
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight(context, dividedBy: 3)),
              UserTextField(
                label: "Email",
                textEditingController: emailTextEditingController,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              UserTextField(
                label: "Password",
                textEditingController: passwordTextEditingController,
                password: true,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              BuildButton(
                  label: "Login",
                  onPressed: () {
                    validation(context);
                  }),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Here ? ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(context, RegistrationPage());
                    },
                    child: Text(
                      " Register Now !",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// validation
  validation(context) async {
    if (emailTextEditingController.text == "" ||
        passwordTextEditingController.text == "") {
      print("Fill all the valid data");
    } else {
      handleSignInEmail();
      // UserCredential result =
      // await _firebaseAuth
      //     .signInWithEmailAndPassword(
      //         email: emailTextEditingController.text,
      //         password: passwordTextEditingController.text)
      //     .then((value) async {
      //
      // });
    }
  }

  /// firebase login
  Future<User> handleSignInEmail() async {
    final prefs = await SharedPreferences.getInstance();
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text);
    final User user = result.user!;
    print("Login successful");
    setState(() {
      prefs.setString('email', user.email!);
      print("Email " + prefs.getString('email')!);
    });
    push(context, HomePage());
    return user;
  }
}
