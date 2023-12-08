
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';

class CountryCode {
  final String code;
  final String imagePath;

  const CountryCode({required this.code,required this.imagePath});
}

class PhoneCountryCode {
  static const pt = CountryCode(code: '+351',imagePath: 'images/flags/portugal.svg');
  static const fr = CountryCode(code: '+33',imagePath: 'images/flags/france.svg');
  static const es = CountryCode(code: '+34',imagePath: 'images/flags/spain.svg');
}

class MyDropdownButton<T> extends StatelessWidget {

  final List<T> items;
  final T? value;
  final String hint;
  final IconData? icon;
  final double? iconSize;
  List<DropdownMenuItem<T>>? dropDownMenuItem;
  final void Function(T?) onChanged;

  MyDropdownButton(
    {super.key,
    required this.items,
    this.value,
    this.icon,
    this.iconSize,
    required this.dropDownMenuItem,
    required this.onChanged,
    this.hint = ''}
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: OtherColors.transparent,
        highlightColor: OtherColors.transparent,
        hoverColor: OtherColors.transparent,
      ),
      child: Stack(
        children: [
          DropdownButton<T>(
            padding: EdgeInsets.zero,
            underline: const SizedBox(),
            value: value,
            onChanged: onChanged,
            items: dropDownMenuItem,
            icon: icon != null ? Icon(icon,size: iconSize,color: GreyScaleColors.grey500) : const SizedBox(),
          ),
        ],
      )
    );
  }
}
