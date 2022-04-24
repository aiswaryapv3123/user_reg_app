import 'dart:io';

import 'package:flutter/material.dart';
import 'package:user_reg_app/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  File? _image;

  void _pickImage(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // final pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      _image = File(image!.path);
    });
    // setState(() {
    //   _image = File(pickedFile!.path);
    // });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage(context);
      },
      child: _image == null
          ? Stack(
            children: [
              Container(
                  width: screenWidth(context, dividedBy: 4),
                  height: screenWidth(context, dividedBy: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person,
                      color: Colors.white,
                      size: screenWidth(context, dividedBy: 5))),
              Positioned(
                  right:screenWidth(context, dividedBy: 40),
                  bottom:screenWidth(context, dividedBy: 300),
                  child: Icon(Icons.camera_alt, size:24,color: Colors.black.withOpacity(0.6),)
              )
            ],
          )
          : Container(
              width: screenWidth(context, dividedBy: 4),
              height: screenWidth(context, dividedBy: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: FileImage(_image!)),
              ),
            ),
    );
  }
}
