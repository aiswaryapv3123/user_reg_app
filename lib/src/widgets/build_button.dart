import 'package:flutter/material.dart';
import 'package:user_reg_app/src/utils/utils.dart';

class BuildButton extends StatefulWidget {
  final String label;
  final Function onPressed;
  final bool loading;
  const BuildButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.loading = false})
      : super(key: key);

  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onPressed();
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context, dividedBy: 30),
                vertical: screenHeight(context, dividedBy: 50)),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: widget.loading == false
                    ? Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white))))));
  }
}
