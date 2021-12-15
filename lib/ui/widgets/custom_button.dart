import 'package:flutter/material.dart';

class CustomButtonPrimary extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const CustomButtonPrimary({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.pink
        ),
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            fontFamily: 'Uniform',
          ),
        ),
      ),
    );
  }
}
