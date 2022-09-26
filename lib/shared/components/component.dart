import 'package:flutter/material.dart';
Widget formField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required IconData prefix,
  required String label,
  String? Function(String?)? validate,
  void Function()? onTap,
  IconData? suffix,
  String? Function(String?)? onSubmit,
  double height=80,
  bool isPassword = false,
  void Function()? suffixPressed,
  String? Function(String?)? onChange,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled:isClickable ,
  onFieldSubmitted: onSubmit,
  onChanged:onChange ,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    ),
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  ),
);

Widget button({
  required void Function() onPressed,
  double height=60,
  double width=double.infinity,
  String? text,
  MaterialColor? color,
  Color textColor=Colors.white,
  double radius=30,
})=>Container(
  height:height ,
  width: width,
  decoration: BoxDecoration(
      color:color ,
      borderRadius:BorderRadius.all(Radius.circular(radius))
  ),
  child:MaterialButton(
    onPressed: onPressed,
    child: Text(text!,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
    textColor: textColor,

  ),
);

void navigatTo(
    context,
    widget
    )=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget,
    )
);

void navigatAndFinish(
    context,
    widget
    )=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),
    (route)=>false
);
