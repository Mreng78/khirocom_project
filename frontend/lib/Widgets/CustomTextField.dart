import 'package:flutter/material.dart';
import 'AppColors.dart';

class CustomTextField extends StatelessWidget {
  final List<dynamic> items;
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
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
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool expands;


  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    required this.labelText,
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
    this.items = const [],
    this.readOnly = false,
    this.onTap,
    this.maxLines,
    this.expands = false,
  });


  InputDecoration _buildDecoration(Color effectiveIconColor, Color effectiveBorderColor) {
    return InputDecoration(
      
      labelText: labelText,
      labelStyle: TextStyle(
        color: textColor ?? Colors.black87,
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
     
      

      hintText: hintText!=null?hintText:"",
      hintStyle: TextStyle(
        color: (textColor ?? Colors.black87).withOpacity(0.5),
        fontFamily: 'Cairo',
        fontSize: 14,
      ),
     
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: effectiveIconColor) : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon, color: effectiveIconColor),
              onPressed: onSuffixIconPressed,
            )
          : null,
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
    );
  }

  TextStyle get _textStyle => TextStyle(
        color: textColor ?? Colors.black87,
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? Appcolors.appmaincolor;
    final effectiveBorderColor = borderColor ?? Appcolors.appmaincolor;

    // If no items provided, return a normal TextFormField
    if (items.isEmpty) {
      return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.right,
        textAlignVertical: expands ? TextAlignVertical.top : null,
        validator: validator,
        onChanged: onChanged,
        style: _textStyle,
        decoration: _buildDecoration(effectiveIconColor, effectiveBorderColor),
        maxLines: obscureText ? 1 : (expands ? null : maxLines),
        expands: obscureText ? false : expands,
        readOnly: readOnly,
        onTap: onTap,
      );




    }

    // With items, return an Autocomplete field
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return items.map((e) => e.toString()).where((item) {
          return item.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
        if (onChanged != null) {
          onChanged!(selection);
        }
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        // Sync the external controller with the field controller
        fieldController.text = controller.text;
        fieldController.addListener(() {
          if (controller.text != fieldController.text) {
            controller.text = fieldController.text;
          }
        });

        return TextFormField(
          controller: fieldController,
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textAlign: TextAlign.right,
          textAlignVertical: expands ? TextAlignVertical.top : null,
          validator: validator,
          onChanged: onChanged,
          style: _textStyle,
          decoration: _buildDecoration(effectiveIconColor, effectiveBorderColor),
          maxLines: obscureText ? 1 : (expands ? null : maxLines),
          expands: obscureText ? false : expands,
          readOnly: readOnly,
          onTap: onTap,
        );




      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: effectiveBorderColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: effectiveBorderColor.withOpacity(0.15),
                ),
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    borderRadius: BorderRadius.circular(
                      index == 0 || index == options.length - 1 ? 12 : 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        option,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textColor ?? Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
