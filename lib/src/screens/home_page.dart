import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_reg_app/src/screens/login_page.dart';
import 'package:user_reg_app/src/utils/utils.dart';
import 'package:user_reg_app/src/widgets/build_button.dart';
import 'package:user_reg_app/src/widgets/user_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var collection;
  String uid = 'T6LfbCZz4XAiZ1kC67Jh';
  String userName = '';
  String name = '';
  String email = '';
  String city = '';
  String phone = '';

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? mail = prefs.getString('email');
    User user = _firebaseAuth.currentUser!;
    print("User UID " + user.uid.toString());
    FirebaseFirestore.instance
        .collection('UserData')
        .where('email', isEqualTo: mail)
        .get()
        .then((value) {
      setState(() {
        userName = value.docs[0].data()['username'] ?? '';
        name = value.docs[0].data()['name'] ?? '';
        email = value.docs[0].data()['email'] ?? '';
        city = value.docs[0].data()['city'] ?? '';
        phone = value.docs[0].data()['phone'] ?? '';
        print("Username " + userName);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    collection = FirebaseFirestore.instance.collection('UserData');
    _getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      floatingActionButton: GestureDetector(
        onTap: () async {
          await FirebaseAuth.instance.signOut();
          push(context, LoginPage());
        },
        child: Container(
          width: screenWidth(context, dividedBy: 7),
          height: screenWidth(context, dividedBy: 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
          child: Icon(Icons.logout, color: Colors.white),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFf5f5f5),
        elevation: 0,
        leading: Container(),
        actions: [
          SizedBox(),
        ],
      ),
      body: Container(
        width: screenWidth(context, dividedBy: 1),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: screenHeight(context, dividedBy: 3)),
            Row(
              children: [
                Text(
                  "Welcome ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            // SizedBox(height: screenHeight(context, dividedBy: 200)),
            Text(
              email,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 40)),
            Text(
              "Your Profile Data ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
            Row(
              children: [
                Text(
                  "Name : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                // Spacer(),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              "UserName : " + userName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              "City : " + city,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              "Phone : " + phone,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
