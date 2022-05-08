import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function? onChanged;
  final Function validate;
  final Widget? icon;
  final Widget? prefixIcon;
  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final int? lines;
  final bool? secureText;
  final double? radius;
  final TextEditingController? controller;
  final double? height;
  final double? verticalMargin;

  const CustomTextField(
      {Key? key,
      this.onChanged,
      required this.validate,
      this.icon,
      this.inputType,
      this.label,
      this.hint,
      this.lines,
      this.secureText,
      this.controller,
      this.radius,
      this.height,
      this.verticalMargin, this.prefixIcon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10)),
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 0),
      child: Container(
        height: height,
        child: TextFormField(
          controller: controller != null ? controller : null,
          maxLines: lines ?? 1,
          style: TextStyle(color: Colors.black),
          obscureText: secureText ?? false,
          cursorColor: Colors.black,
          keyboardType: inputType ?? TextInputType.multiline,
          validator: (value) {
            return validate(value);
          },
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(color: Colors.black, width: 0.6)),
              errorStyle: TextStyle(fontSize: 10.0),
              errorMaxLines: 2,
              contentPadding: EdgeInsets.only(
                  right: 20.0, top: 10.0, bottom: 10.0, left: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(color: Colors.black, width: 0.6)),
              filled: true,
              fillColor: Colors.grey[50],
              suffixIcon: icon ?? null,
              prefixIcon: prefixIcon ?? null,
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 40, maxWidth: 40),
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.black),
              hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02),
              hintText: hint),
          // onChanged: (String value) {
          //   return onChanged!(value);
          // },
        ),
      ),
    );
  }
}
