import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svmdiresa/ui/constants.dart';

class CustomInput extends StatelessWidget {
  final Function(String)? onChanged;
  final String? title;
  final String? hintText;
  final String? initialValue;
  final Function()? onTap;
  final bool? readOnly;
  final int? characterl;
  final TextInputType? type;
  const CustomInput(
      {Key? key,
      this.onChanged,
      this.title,
      this.hintText,
      this.initialValue,
      this.type,
      this.characterl,
      this.onTap,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            title!,
            style: kLabelStyle,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: type ?? TextInputType.number,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(characterl),
            ],
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'NunitoSans',
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: hintText,
            ),
            onTap: onTap,
            readOnly: readOnly!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Este campo no puede ser vacio';
              } else {
                return null;
              }
            },
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
