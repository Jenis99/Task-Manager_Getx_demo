import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final bool? showCursor;
  final FontWeight? fontWeight;
  final TextEditingController? controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final double? fontSize;
  final int? maxLength;
  final double? radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? hintTextColor;
  final double? hintFontSize;
  final FontWeight? hintTextWeight;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final VoidCallback? onTap;
  final Color? enableColor;
  final Color? disabledColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final TextCapitalization? textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final double? textFieldHeight;
  final List<BoxShadow>? boxShadow;
  final ScrollController? scrollController;

  CustomTextField({
    Key? key,
    this.textInputFormatter,
    this.boxShadow,
    this.onFieldSubmitted,
    this.fontWeight,
    this.showCursor,
    this.onChanged,
    this.maxLine = 1,
    this.maxLength,
    this.radius,
    this.fontSize,
    this.fillColor,
    this.textColor,
    this.disabledColor,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.hintTextWeight,
    this.textAlign,
    this.textAlignVertical,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    this.controller,
    this.contentPadding,
    this.prefixWidget,
    this.readOnly = false,
    this.textCapitalization,
    this.textInputAction,
    this.validator,
    this.textFieldHeight,
    this.scrollController,
  }) : super(key: key);

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscure,
      builder: (context, bool isObscure, _) {
        if (!isPassword) {
          isObscure = false;
        }
        return Stack(
          children: [
            Container(
              height: textFieldHeight ?? SizeUtils.verticalBlockSize * 7.1,
              // width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                boxShadow: boxShadow ??
                    [
                      BoxShadow(
                        // offset: Offset(-
                        // .horizontalBlockSize * 0.01, -SizeUtils.horizontalBlockSize * 0.05),
                        color: AppColors.grey.withOpacity(0.1),
                        spreadRadius: 0.5,
                        blurRadius: 6,
                      ),
                    ],
              ),
            ),
            TextFormField(
              scrollController: scrollController,
              onFieldSubmitted: onFieldSubmitted,
              showCursor: showCursor ?? true,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              readOnly: readOnly,
              style: TextStyle(
                color: textColor ?? AppColors.blackColor,
                fontSize: fontSize ?? SizeUtils.fSize_12(),
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
              onTap: onTap,
              obscureText: isObscure,
              inputFormatters: textInputFormatter,
              textInputAction: textInputAction,
              obscuringCharacter: '*',
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLine,
              maxLength: maxLength,
              keyboardType: keyboardType,
              focusNode: focusNode,
              textAlignVertical: textAlignVertical,
              cursorColor: cursorColor ?? AppColors.blackColor,
              textAlign: textAlign ?? TextAlign.start,
              enabled: enabled,
              validator: validator,
              decoration: InputDecoration(
                errorMaxLines: 1,
                prefix: prefixWidget,
                contentPadding: contentPadding,
                isDense: true,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon == null && isPassword
                    ? IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _isObscure.value = !isObscure;
                        },
                      )
                    : suffixIcon,
                counterText: "",
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintTextColor ?? AppColors.grey,
                  fontSize: hintFontSize ?? SizeUtils.fSize_14(),
                  fontWeight: hintTextWeight ?? FontWeight.w400,
                ),
                filled: true,
                fillColor: fillColor ?? AppColors.whiteColor,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(color: disabledColor ?? Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(color: enableColor ?? AppColors.textColor),
                ),
                // border: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(color: focusedColor ?? AppColors.textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(color: focusedColor ?? AppColors.textColor),
                ),
                // errorBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                //   borderSide: const BorderSide(color: Colors.red),
                // ),
              ),
            ),
          ],
        );
      },
    );
  }
}
