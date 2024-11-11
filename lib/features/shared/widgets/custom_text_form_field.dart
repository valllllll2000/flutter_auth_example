import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted, this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final transparentBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    const specialBorderRadius = BorderRadius.only(
        topLeft: borderRadius,
        bottomLeft: borderRadius,
        bottomRight: borderRadius);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: specialBorderRadius,
          boxShadow: [
            BoxShadow(
                color: errorMessage == null
                    ? Colors.black.withOpacity(0.06)
                    : Colors.red.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: TextFormField(
        initialValue: initialValue,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
              color: errorMessage != null
                  ? Colors.red.withOpacity(0.6)
                  : Colors.black.withOpacity(0.6),
              fontSize: 18),
          enabledBorder: transparentBorder,
          focusedBorder: transparentBorder,
          errorBorder: transparentBorder,
          focusedErrorBorder: transparentBorder,
          isDense: true,
          label: label != null ? Text(label!) : null,
          labelStyle: TextStyle(
              color: errorMessage != null
                  ? Colors.red.withOpacity(0.6)
                  : Colors.black.withOpacity(0.6)),
          hintText: hint,
          errorStyle: TextStyle(color: Colors.red.withOpacity(0.6)),
          errorText: errorMessage,
          focusColor: colors.primary,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
