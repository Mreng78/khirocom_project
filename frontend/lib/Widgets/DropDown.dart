import 'package:flutter/material.dart';
import 'AppColors.dart';

class Dropdown extends StatelessWidget {
  final List<dynamic>? items;
  final String? hintText;
  final String? label;
  final String? value;
  final Function(dynamic)? onChanged;
  final IconData? icon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;

  const Dropdown({
    super.key,
    this.items,
    this.hintText,
    this.label,
    this.value,
    this.onChanged,
    this.icon,
    this.fillColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? Appcolors.appmaincolor;
    final effectiveBorderColor = borderColor ?? Appcolors.appmaincolor;

    return DropdownButtonFormField<dynamic>(
      initialValue: value,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: effectiveIconColor),
      dropdownColor: fillColor ?? Colors.white,
      style: TextStyle(
        color: textColor ?? Colors.black87,
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: textColor ?? Colors.black87,
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        
        hintText: hintText,
        hintStyle: TextStyle(
          color: (textColor ?? Colors.black87).withOpacity(0.5),
          fontFamily: 'Cairo',
          fontSize: 14,
        ),
        prefixIcon: icon != null ? Icon(icon, color: effectiveIconColor) : null,
        filled: true,
        fillColor: fillColor ?? Colors.white,
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
      items: items?.map((item) {
        return DropdownMenuItem<dynamic>(
          value: item,
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            item.toString(),
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black87,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}