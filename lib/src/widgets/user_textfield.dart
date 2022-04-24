import 'package:flutter/material.dart';
import 'package:user_reg_app/src/utils/utils.dart';

class UserTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool password;
  final bool number;
  const UserTextField(
      {Key? key,
      required this.label,
      this.password = false,
      required this.textEditingController,
        this.number = false,
      })
      : super(key: key);

  @override
  _UserTextFieldState createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: widget.textEditingController,
        obscureText: widget.password ? true : false,
        keyboardType: widget.number ? TextInputType.number : TextInputType.text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.label,
          labelStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 50),
              vertical: screenHeight(context, dividedBy: 120)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 0.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 0.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
