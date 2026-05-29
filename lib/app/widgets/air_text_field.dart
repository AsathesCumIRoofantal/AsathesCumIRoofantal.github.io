// ============================================================
//  AIR App – Reusable Text Field
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirTextField extends StatelessWidget {
  final String          hint;
  final String?         label;
  final IconData?       prefixIcon;
  final Widget?         suffix;
  final bool            obscure;
  final TextInputType   keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int   maxLines;
  final bool  readOnly;
  final bool  autofocus;

  const AirTextField({
    super.key,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.suffix,
    this.obscure      = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
    this.maxLines     = 1,
    this.readOnly     = false,
    this.autofocus    = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller:      controller,
      obscureText:     obscure,
      keyboardType:    keyboardType,
      validator:       validator,
      onChanged:       onChanged,
      maxLines:        maxLines,
      readOnly:        readOnly,
      autofocus:       autofocus,
      style:           TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
        labelText:       label,
        hintText:        hint,
        hintStyle:       TextStyle(color: theme.hintColor, fontSize: 14.sp),
        prefixIcon:      prefixIcon != null ? Icon(prefixIcon, size: 20.r) : null,
        suffixIcon:      suffix,
        filled:          true,
        fillColor:       theme.colorScheme.surfaceContainerHighest.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide:   BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide:   BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide:   BorderSide(color: theme.colorScheme.error, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}
