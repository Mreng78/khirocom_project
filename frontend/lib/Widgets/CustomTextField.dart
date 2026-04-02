import 'package:flutter/material.dart';
import 'AppColors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? fillColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.onSuffixIconPressed,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? Appcolors.iconColor;
    final effectiveBorderColor = borderColor ?? Appcolors.iconColor;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textAlign: TextAlign.right,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
        color: textColor ?? Colors.black87,
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: (textColor ?? Colors.grey).withOpacity(0.7),
          fontFamily: 'Cairo',
          fontSize: 16,
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: effectiveIconColor) : null,
        suffixIcon: suffixIcon != null 
            ? IconButton(
                icon: Icon(suffixIcon, color: effectiveIconColor),
                onPressed: onSuffixIconPressed,
              )
            : null,
        filled: true,
        fillColor: fillColor ?? Appcolors.iconColor.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: effectiveBorderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: effectiveBorderColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: effectiveBorderColor,
            width: 2.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
      ),
    );
  }
}
