import 'package:country_icons/country_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';

class AccountPage extends StatefulWidget {

  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    }
  }

  final TextEditingController _dateController = TextEditingController();
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.my_account,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AssetResources.welcomeBackImage,
                          height: 75.h,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Tedfinance Lateef',
                          style: CustomTextStyles.titleMedium18
                              .copyWith(fontSize: 18.0),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '@lateef',
                          style: CustomTextStyles.bodySmallGray5004.copyWith(
                            fontSize: 13.0,
                            color: AppColors.tedGreyText,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Account No: 2001400245',
                          style: CustomTextStyles.titleSmallBlack900.copyWith(
                            fontSize: 13.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -MediaQuery.of(context).size.width / 4.5,
                    top: -5,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2.8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryButtonColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: AppColors.tedGrey2.withOpacity(0.5))),
                      ),
                      child: const CustomTextFormField(
                        borderDecoration: InputBorder.none,
                        hintText: 'Tedfinance',

                        // Add your TextFormField properties here
                      ),
                    ),

                    30.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: AppColors.tedGrey2.withOpacity(0.5))),
                      ),
                      child: const CustomTextFormField(
                        borderDecoration: InputBorder.none,
                        hintText: 'Lateef',

                        // Add your TextFormField properties here
                      ),
                    ),
                    30.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: AppColors.tedGrey2.withOpacity(0.5))),
                      ),
                      child: CustomTextFormField(
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CountryIcons.getSvgFlag('ng'),
                        ),
                        borderDecoration: InputBorder.none,
                        hintText: '+234(703) 250 2259',

                        // Add your TextFormField properties here
                      ),
                    ),
                    30.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.tedGrey2.withOpacity(0.5)),
                        ),
                      ),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Gender',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'female',
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle the selected value here
                        },
                      ),
                    ),
                    30.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: AppColors.tedGrey2.withOpacity(0.5))),
                      ),
                      child: CustomTextFormField(
                        controller: _dateController,
                        borderDecoration: InputBorder.none,
                        hintText: '02/09/2022',
                        suffix: InkWell(
                          onTap: () => _selectDate(context),
                          child: Padding(
                            padding:  EdgeInsets.all(15.0.sp),
                            child: SvgPicture.asset(AssetResources.blueCalendarIcon, height: 20, width: 30,),
                          ),
                        ),

                        // Add your TextFormField properties here
                      ),
                    ),
                    40.verticalSpace,
                    AppButton(
                      width: 260.w,
                      height: 60.h,
                      radius: 20.r,
                      onPressed: (){

                      },
                      text: 'Update Profile',

                    )
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
