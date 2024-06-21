import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/upload_files.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/kyc_progress_model.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/nin_model.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/models/auth_models/user.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/string_resources.dart';
import 'additional_info.dart';

class PersonalBio extends StatefulWidget {
   final NINModel? ninModel;

  const PersonalBio({super.key,

     this.ninModel,
  });

  @override
  State<PersonalBio> createState() => _PersonalBioState();
}

class _PersonalBioState extends State<PersonalBio> {
  bool isHovered = false;
  late KYCProvider kycProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  User? user;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String firstName = "";
  String lastName = "";
  String birthDate = "";
  String gender = "";
  KYCProgressModel? kycProgressModel;

@override
  void initState() {
    super.initState();
    final response = widget.ninModel;
    firstNameController.text = response?.firstName ?? "";
    lastNameController.text = response?.lastName ?? "";
    genderController.text = response?.gender ?? "";
    dobController.text = response?.birthDate ?? "";
    phoneController.text = response?.phoneNumber ?? "";
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    countryController.dispose();
    phoneController.dispose();
    cityController.dispose();
    stateController.dispose();
    dobController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  Future<bool?> onBackPress(context, bool value) {
    return showDialog <bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you wish to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => {Navigator.pop(context, false)},
            ),
            TextButton(
                onPressed: () => {Navigator.pop(context, true)},
                child: Text('Exit'))
          ],
        )
    )  ;
  }
  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TedTopWidget(
                  titleText: StringResources.personal_bio,
                  rightIconOnTap: () {
                    // PageNavigator(ctx: context).nextPageOnly(
                    //     page: const KYCVerification());
                  },
                  trailing: Container(),
                ),

                Center(child: SvgPicture.asset(AssetResources.step1)),
                20.verticalSpace,
                CustomTextFormField(
                  hintText: 'First Name',
                  textInputType: TextInputType.text,
                  initialValue: widget.ninModel?.firstName,
                  controller: firstNameController,
                  enabled: false,

                ),
                25.verticalSpace,
                CustomTextFormField(
                  hintText: 'Last Name',
                  textInputType: TextInputType.text,
                  initialValue: widget.ninModel?.lastName,
                  controller: lastNameController,
                  enabled: false,

                ),
                25.verticalSpace,
                CustomTextFormField(
                    hintText: 'Gender',
                    textInputType: TextInputType.text,
                    initialValue: widget.ninModel?.gender,
                  controller: genderController,
                  enabled: false,


                ),
                25.verticalSpace,
                CustomTextFormField(
                  hintText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  initialValue: widget.ninModel?.phoneNumber,
                  controller: phoneController,
                  enabled: false,


                ),
                25.verticalSpace,
                 CustomTextFormField(
                  hintText: 'Home Address',
                  textInputType: TextInputType.text,
                  maxLines: 3,
                  controller:addressController,
                   validator: (v) {
                     if (v!.isEmpty) {
                       return "Field is Required";
                     }
                     return null;
                   },
                ),
                25.verticalSpace,
                CSCPicker(
                  showCities: true,
                  onCountryChanged: (value) {
                    setState(() {
                       countryValue = value;
                    });
                  },
                  onStateChanged:(value) {
                    setState(() {
                      stateValue = value ?? '';
                    });
                  },
                  onCityChanged:(value) {
                    setState(() {
                      cityValue = value ?? '';
                    });
                  },
                ),
                25.verticalSpace,

                1.verticalSpace,
                CustomTextFormField(
                  hintText: 'Date of Birth',
                  textInputType: TextInputType.datetime,
                  initialValue: widget.ninModel?.birthDate,
                  controller: dobController,
                  enabled: false,

                  suffix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      AssetResources.calendarIcon,
                      height: 10.h,
                    ),
                  ),
                ),
                35.verticalSpace,
                Text(StringResources.Please_kindly_ensure,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            wordSpacing: 4,
                            letterSpacing: 1.5))),
                35.verticalSpace,
                Center(
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {
                        isHovered = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    child: AppButton(
                      onPressed: () {
                        updateBio();

                      },
                      text: 'Continue',
                      color: isHovered
                          ? AppColors.primaryColor
                          : AppColors.tedButtonGrey,
                      radius: 17.r,
                      height: 52,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
      ),
    );
  }
  void updateBio() async {
    if (_formKey.currentState!.validate()) {
      try {
        final firstName = firstNameController.text.trim();
        final lastName = lastNameController.text.trim();
        final gender = genderController.text.trim();
        final phone = phoneController.text.trim();
        final country = countryValue;
        final city = cityValue;
        final state = stateValue;
        final dob = dobController.text.trim();
        final address = addressController.text.trim();
        final zipCode = zipCodeController.text.trim();

        final result = await kycProvider.updateBio(
          firstName,
          lastName,
          gender,
          phone,
          country,
          city,
          state,
          dob,
          address,
        );

        if (result) {
          pushToWithRoute(
            context,
            CustomRoutes.fadeIn(const UploadFiles()),
          );
        } else {
          AlertToast(context: context).showError('Failed to update bio');
        }

      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    }
  }
}
