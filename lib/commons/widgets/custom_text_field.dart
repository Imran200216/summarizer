import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summarize/core/themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode? focusNode; // Add FocusNode
  final bool readOnly;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool isPassword;
  final bool hasBorder;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.isPassword = false,
    this.hasBorder = true,
    this.textEditingController,
    this.onTap,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.focusNode, // Add focusNode parameter
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode, // Attach the FocusNode
      autocorrect: true,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      validator: widget.validator,
      cursorColor: AppColors.primaryColor,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      controller: widget.textEditingController,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColors.titleColor,
      ),
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide:
              widget.hasBorder
                  ? BorderSide(
                    color: AppColors.outlinedBtnBorderColor,
                    width: 1,
                  )
                  : BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.titleColor),
      ),
    );
  }
}
