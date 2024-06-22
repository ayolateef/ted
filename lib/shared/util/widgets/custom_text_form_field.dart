import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

import '../../../core/env/utils/colors.dart';
import '../asset_images.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.headerText,
    this.headerTextFontWeight,
    this.radius,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.enabled = true,
    this.validator,
    this.onChange,
    this.focusDecoration,
    this.maxLength,
    this.headerTextColor,
    this.textFontSize,
    this.textInputFormatters,
    this.initialValue,
  }) : super(
          key: key,
        );

  final Color? headerTextColor;
  final String? headerText;

  final double? radius;

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;
  final int? maxLength;

  final bool? autofocus;
  final bool? enabled;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;
  final String? initialValue;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? textInputFormatters;

  final InputBorder? borderDecoration;
  final InputBorder? focusDecoration;

  final Color? fillColor;

  final bool? filled;
  final double? textFontSize;
  final FontWeight? headerTextFontWeight;

  final FormFieldValidator<String>? validator;
  final Function(String val)? onChange;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
      width: width ?? double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerText != null)
            Column(
              children: [
                Text(headerText ?? '',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: textFontSize ?? 15.sp,
                          fontWeight: FontWeight.w600,
                          color: headerTextColor ?? AppColors.black),
                    )),
              ],
            ),
          10.verticalSpace,
          TextFormField(
            maxLength: maxLength,
            onChanged: onChange ?? (f) => f,
            enabled: enabled,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: controller,
            focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style: textStyle ?? theme.textTheme.titleMedium,
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
            inputFormatters: textInputFormatters,
          ),
        ],
      ));
  InputDecoration get decoration => InputDecoration(
        counterText: "",
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleSmallBluegray300,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 19.h,
              right: 19.h,
              bottom: 19.h,
              left: 19.h,
            ),
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15.r),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        focusedBorder: focusDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillGrayTL6 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineIndigoTL10 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: appTheme.indigo100,
          width: 1,
        ),
      );
  static OutlineInputBorder get fillGrayTL8 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillBlue => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGrayTL14 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.h),
        borderSide: BorderSide.none,
      );
}




class SelectedCurrency {
  String? _selectedCurrency;

  String? get selectedCurrency => _selectedCurrency;

  void updateSelectedCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
  }
}
class CustomDropdownFormField extends StatefulWidget {
  final String headerText;
  final String hintText;
  final double? textFontSize;
  final Color? headerTextColor;
  final List<String> currencies;
  final ValueChanged<String>? onChanged;
  final SelectedCurrency? selectedCurrency;
  final Widget? dropdownItem;
  final Widget? prefix;
  final Widget? currencyWidget;

  const CustomDropdownFormField({
    Key? key,
    required this.headerText,
    required this.hintText,
    required this.currencies,
    this.onChanged,
    this.textFontSize,
    this.headerTextColor,
    this.selectedCurrency,
    this.dropdownItem,
    this.prefix, this.currencyWidget
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(widget.headerText,  style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: widget.textFontSize ?? 15.sp,
                fontWeight: FontWeight.w600,
                color: widget.headerTextColor ?? AppColors.black),
          )),
        ),
        Container(
          height: 62.h,
          padding: const EdgeInsets.only(right: 16.0, left: 5.0, top: 3.0),

          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0.r),
          ),
          child: DropdownButtonFormField<String>(
            padding: const EdgeInsets.only(bottom: 5,),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14.sp),
              alignLabelWithHint: true,
              prefixIcon: widget.prefix,

              border: InputBorder.none, // Dropdown icon
            ),
            value: widget.selectedCurrency?.selectedCurrency,
            onChanged: (value) {
              setState(() {
                widget.selectedCurrency?.updateSelectedCurrency(value!);
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value!);
              }
            },
            items: widget.currencies
                .map((currency) => DropdownMenuItem(
              value: currency,
              child: widget.currencyWidget ?? Text(currency),
            ))
                .toList(),
            icon: SvgPicture.asset(AssetResources.dropdownIcon,),
            iconDisabledColor: null,

          ),
        ),
      ],
    );
  }
}








class AppDropdownModal<T extends DropdownBaseModel> extends StatefulWidget {
  final String headerText;
  final String? descriptionText;

  final String? hintText;
  final bool enabled;
  final String? Function(String?)? validator;
  final List<T>? options;
  final T? value;
  final bool hasSearch;
  final String? parentName;
  final double modalHeight;
  final double? textFontSize;
  final Color? headerTextColor;
  final Widget? prefixIcon;






  final void Function(T?) onChanged;
  final void Function(bool?)? onStop;
  bool useMargin;
  bool isLoading;
  AppDropdownModal(
      {Key? key,
        required this.headerText,
        this.hintText,
        this.enabled = true,
        required this.onChanged,
        this.validator,
        this.parentName,
        this.descriptionText,
        required this.options,
        this.value,
        this.useMargin = true,
        required this.modalHeight,
        this.hasSearch = false,
        this.isLoading = false,
        this.onStop,
        this.textFontSize,
        this.headerTextColor, this.prefixIcon,
      })
      : super(key: key);

  @override
  State<AppDropdownModal<T>> createState() => _AppDropdownModalState<T>();
}

class _AppDropdownModalState<T extends DropdownBaseModel> extends State<AppDropdownModal<T>> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  List<T> filteredItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      controller.text = widget.value!.displayName;
    } else {
      controller.clear();
    }
    if (searchController.text.isEmpty) {
      filteredItems = widget.options!.cast<T>();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerText != null)
        Text(widget.headerText ?? '',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: widget.textFontSize ?? 15.sp,
                  fontWeight: FontWeight.w600,
                  color: widget. headerTextColor ?? AppColors.black),
            )),
        CustomTextField(
          prefix: widget.prefixIcon,
          hint: widget.hintText,
          useMargin: widget.useMargin,
          // enabled: widget .enabled,
          readOnly: true,
          // onChanged: add_customer_business.onChanged,
          validator: widget.validator,
          textEditingController: controller,
          suffix: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: widget.isLoading
                ? const CupertinoActivityIndicator()
                : Icon(
              Icons.arrow_drop_down,
              size: 24,
              color:
              filteredItems.isEmpty ? Colors.grey : Colors.grey.shade700,
            ),
          ),
          onTap: filteredItems.isEmpty || widget. enabled == false
              ? null
              : () async {
            // if (filteredItems.isEmpty) toast("Empty List");
            _showModal(widget.headerText);
          },

        ),
      ],
    );
  }

  void _showModal(String headerText) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, setModalState) {
            return Container(
              padding: MediaQuery.of(_).viewInsets,
              height: widget.modalHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            headerText.trim().endsWith('*')
                                ? headerText.trim().substring(
                                0, headerText.trim().lastIndexOf('*'))
                                : headerText.trim(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color:  Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 13.w),
                            child: IconButton(
                              onPressed: () {
                                pop(context);
                              },
                                  // GetIt.I.get<NavigationService>().pop(),
                              icon: Container(
                                decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.grey[65]!, width: 2),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13.h),
                    _separator,
                    SizedBox(height: 13.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.hasSearch
                              ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                List temp = widget.options!
                                    .where((element) => element
                                    .displayName
                                    .toLowerCase()
                                    .contains(
                                    value.toLowerCase()))
                                    .toList();
                                setModalState(() {
                                  filteredItems = temp as List<T>;
                                });
                              },
                              style: TextStyle(
                                color:  Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                height: 1.4,
                              ),
                              decoration: InputDecoration(
                                fillColor: widget.enabled ?  Colors.white : Colors.transparent,
                                //const Color(0xFFF4F4F4) :
                                isDense: true,
                                filled: true,

                                prefixIcon: const Icon(
                                  Icons.search,
                                  color:  Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade800, // Deep grey border
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade800, // Deep grey border
                                    width: 1.0,
                                  ),
                                ),
                                //InputBorder.none,
                                hintText:"Search",
                                hintStyle: TextStyle(
                                  color:  Colors.black,
                                  fontSize: 14.sp,
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                          widget.hasSearch
                              ? SizedBox(height: 10.h)
                              : const SizedBox.shrink(),
                          Expanded(
                            child: ListView.separated(
                              itemCount: filteredItems.length,
                              separatorBuilder: (_, index) => _separator,
                              itemBuilder: (_, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    // vertical: 13.h,
                                  ),
                                  title: Text(
                                    filteredItems[index]
                                        .displayName,
                                    // .capitalize(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      height: 1.4,
                                    ),
                                  ),

                                  onTap: () {
                                    controller.text =
                                        filteredItems[index].displayName;
                                    widget.onChanged(filteredItems[index]);
                                    pop(context);
                                    // locator.get<NavigationService>().pop();


                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

final Divider _separator = Divider(
  height: 0,
  thickness: .5,
  color: Color(0xFFDCD6CF),
);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}



class CustomTextField extends FormField<String> {
  final String? header;
  final bool? enable;
  final String? hint;
  final bool obscureText;
  final Widget? suffix;
  final Widget? outerSuffix;
  final bool readOnly;
  final Widget? prefix;
  final bool? headerLess;
  final bool autoFocus;
  final bool useMargin;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final int? lines;
  final VoidCallback? onTap;
  final Color? textFieldBackgroundColor;
  final Color? color;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? textInputFormatters;
  final FieldType? type;
  final ActionType? textActionType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? textEditingController;
  final bool alignLabelWithHint;
  final double? textFontSize;

  CustomTextField(
      {Key? key,
        this.header,
        this.textFontSize,
        this.type,
        this.hint,
        this.obscureText = false,
        this.suffix,
        this.readOnly = false,
        this.outerSuffix,
        this.headerLess = false,
        this.prefix,
        this.minLines,
        this.maxLength,
        this.color = Colors.transparent,
        this.maxLines,
        this.lines,
        this.onTap,
        this. textFieldBackgroundColor,
        this.autoFocus = false,
        this.textEditingController,
        this.textInputFormatters,
        this.validator,
        this.onSubmit,
        this.textActionType,
        this.focusNode,
        this.onChanged,
        this.useMargin = true,
        this.alignLabelWithHint = false,
        this.floatingLabelBehavior,
        this.enable})
      : super(
    key: key,
    validator: validator,
    enabled: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    initialValue:
    textEditingController != null ? textEditingController.text : "",
    builder: (FormFieldState<String> field) {
      final _CustomTextFieldState state = field as _CustomTextFieldState;

      void onChangedHandler(String value) {
        field.didChange(value);
        if (onChanged != null) {
          onChanged(value);
        }
      }

      TextInputType getTextInputType() {
        switch (type) {
          case FieldType.email:
            return TextInputType.emailAddress;

          case FieldType.phone:
            return TextInputType.phone;

          case FieldType.multiline:
            return TextInputType.multiline;

          case FieldType.number:
            return TextInputType.number;
          default:
            return TextInputType.text;
        }
      }

      TextInputAction getActionInputType() {
        switch (textActionType) {
          case ActionType.next:
            return TextInputAction.next;

          case ActionType.done:
            return TextInputAction.done;

          default:
            return TextInputAction.next;
        }
      }

      return Container(
        margin: useMargin
            ? EdgeInsets.only(bottom: 20.h)
            : const EdgeInsets.symmetric(vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: AppColors.grey[12]!, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.007),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    // borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        prefix ??
                            SizedBox(
                              width: 15.w,
                              height: 79.h,
                            ),
                        Expanded(
                          child: TextField(
                            onTap: onTap,
                            // focusNode: _node,
                            cursorColor: AppColors.primaryColor,
                            enabled: enable,
                            readOnly: readOnly,
                            onChanged: onChangedHandler,
                            textInputAction: getActionInputType(),

                            obscureText: obscureText,
                            keyboardType: getTextInputType(),
                            controller: textEditingController,
                            onSubmitted: onSubmit,
                            inputFormatters: textInputFormatters,
                            minLines: lines ?? minLines ?? 1,
                            maxLines: lines ?? maxLines ?? 1,

                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              labelText: header,
                              isCollapsed: true,
                              alignLabelWithHint: alignLabelWithHint,
                              labelStyle: TextStyle(
                                letterSpacing: 0.1,
                                color: textFieldBackgroundColor ??  const Color(0xff4B4B4B),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                              border: const NothingInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: suffix ?? const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
                if (field.errorText != null)
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 4),
                    child: Text(
                      field.errorText ?? "",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      );
    },
  );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('color', color));
  }
}

class _CustomTextFieldState extends FormFieldState<String> {
  late TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.textEditingController ?? _controller;

  @override
  CustomTextField get widget => super.widget as CustomTextField;

  TextInputType getTextInputType() {
    switch (widget.type) {
      case FieldType.email:
        return TextInputType.emailAddress;

      case FieldType.phone:
        return TextInputType.phone;

      case FieldType.multiline:
        return TextInputType.multiline;

      case FieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.textEditingController == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.textEditingController!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textEditingController != oldWidget.textEditingController) {
      oldWidget.textEditingController?.removeListener(_handleControllerChanged);
      widget.textEditingController?.addListener(_handleControllerChanged);

      if (oldWidget.textEditingController != null &&
          widget.textEditingController == null) {
        _controller = TextEditingController.fromValue(
            oldWidget.textEditingController!.value);
      }
      if (widget.textEditingController != null) {
        setValue(widget.textEditingController!.text);
        if (oldWidget.textEditingController == null) {
          _controller;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

enum FieldType {
  text,
  email,
  phone,
  password,
  dropdown,
  number,
  multiline,
  date
}

enum ActionType { next, done }

class NothingInputBorder extends InputBorder {
  /// Creates an underline border for an [InputDecorator].
  ///
  /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
  /// null). Applications typically do not specify a [borderSide] parameter
  /// because the input decorator substitutes its own, using [copyWith], based
  /// on the current theme and [InputDecorator.isFocused].
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 4.0. The [borderRadius]
  /// parameter must not be null.
  const NothingInputBorder({
    BorderSide borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  }) : super(borderSide: borderSide);

  /// The radii of the border's rounded rectangle corners.
  ///
  /// When this border is used with a filled input decorator, see
  /// [InputDecoration.filled], the border radius defines the shape
  /// of the background fill as well as the bottom left and right
  /// edges of the underline itself.
  ///
  /// By default the top right and top left corners have a circular radius
  /// of 4.0.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  NothingInputBorder copyWith(
      {BorderSide? borderSide, BorderRadius? borderRadius}) {
    return NothingInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  NothingInputBorder scale(double t) {
    return NothingInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect? rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(
          rect!.left, rect.top, rect.width, rect.height - borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is NothingInputBorder) {
      return NothingInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is NothingInputBorder) {
      return NothingInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        double? gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection? textDirection,
      }) {
    if (borderRadius.bottomLeft != Radius.zero ||
        borderRadius.bottomRight != Radius.zero) {
      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    }
    // canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorder && other.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;
}

abstract class DropdownBaseModel {
  String get displayName;
}

