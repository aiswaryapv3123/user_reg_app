import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_reg_app/src/screens/home_page.dart';
import 'package:user_reg_app/src/screens/login_page.dart';
import 'package:user_reg_app/src/utils/utils.dart';
import 'package:user_reg_app/src/widgets/build_button.dart';
import 'package:user_reg_app/src/widgets/profile_icon.dart';
import 'package:user_reg_app/src/widgets/user_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();

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
              SizedBox(height: screenHeight(context, dividedBy: 10)),
              ProfileIcon(),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              UserTextField(
                label: "Name",
                textEditingController: nameTextEditingController,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              UserTextField(
                label: "UserName",
                textEditingController: usernameTextEditingController,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              UserTextField(
                label: "phone",
                textEditingController: phoneTextEditingController,
                number: true,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
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
              UserTextField(
                label: "Confirm Password",
                textEditingController: confirmPasswordTextEditingController,
                password: true,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              UserTextField(
                label: "Your City",
                textEditingController: cityTextEditingController,
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              BuildButton(
                  label: "Register",
                  onPressed: () {
                    validation(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  validation(context) async {
    if (emailTextEditingController.text == "" ||
        passwordTextEditingController.text == "" ||
        confirmPasswordTextEditingController.text == "" ||
        nameTextEditingController.text == "" ||
        usernameTextEditingController.text == "" ||
        phoneTextEditingController.text == "" ||
        cityTextEditingController.text == "") {
      print("Fill all the valid data");
    } else if (passwordTextEditingController.text !=
        confirmPasswordTextEditingController.text) {
      print("Password doesn't match");
    } else {
      /// firebase user registration
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailTextEditingController.text,
              password: confirmPasswordTextEditingController.text)
          .then((value) {
        FirebaseFirestore.instance.collection("UserData").add({
          'name': nameTextEditingController.text,
          'username': usernameTextEditingController.text,
          'phone': phoneTextEditingController.text,
          'city': cityTextEditingController.text,
          'email': emailTextEditingController.text,
          'password': passwordTextEditingController.text,
        });
        print("User registration");
        push(context, LoginPage());
      });
    }
  }
}
