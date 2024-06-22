import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/upload_files.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import 'kyc_verification.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isHovered = false;
  final TextEditingController _sourceOfIncomeController = TextEditingController();
  final TextEditingController _statusController= TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _incomeBandController = TextEditingController();
  late KYCProvider kycProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> incomeBands = [
    'Less than 500,000',
    '500,000 - 1,000,000',
    '1,000,000 - 2,000,000',
    '2,000,000 - 5,000,000',
    'More than 5,000,000',
  ];
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
                      titleText: StringResources.additional_info,
                      rightIconOnTap: () {
                        // PageNavigator(ctx: context).nextPageOnly(
                        //     page: const KYCVerification());
                      },
                    ),
                    25.verticalSpace,
                    // Stepper(steps: steps)
                    // const CustomTextFormField(
                    //   hintText: 'Phone Number',
                    //   textInputType: TextInputType.phone,
                    // ),
                    25.verticalSpace,
                     CustomTextFormField(
                      hintText: 'Source of Income',
                      textInputType: TextInputType.text,
                      controller: _sourceOfIncomeController,
                    ),
                    25.verticalSpace,
                     CustomTextFormField(
                      hintText: 'Employment Status',
                      textInputType: TextInputType.text,
                      controller: _statusController
                    ),
                    25.verticalSpace,
                     CustomTextFormField(
                      hintText: 'Occupation',
                      textInputType: TextInputType.text,
                       controller: _occupationController
                    ),
                    25.verticalSpace,
                    CustomTextFormField(
                      hintText: 'Income Band',
                      textInputType: TextInputType.text,
                      controller: _incomeBandController,
                      suffix: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () => _showIncomeBandDropdown(context, _incomeBandController),
                          child: SvgPicture.asset(
                            AssetResources.dropdownIcon,
                            height: 10,width: 10,),
                        ),
                      ),
                    ),
                    25.verticalSpace,
                    const BigPinkContainer(
                      text: StringResources.Additional_info_required,
                    ),
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
                          onPressed: () =>  additionalInfo(),
                          text: 'Continue',
                          color: isHovered ? AppColors.primaryColor : AppColors.tedButtonGrey,
                          radius: 17.r,
                          height: 52,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
  void _showIncomeBandDropdown(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: incomeBands.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(incomeBands[index]),
              onTap: () {
                controller.text = incomeBands[index];
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  additionalInfo() async {
    if (_formKey.currentState!.validate()) {
      try {
        final sourceOfIncome = _sourceOfIncomeController.text.trim();
        final employmentStatus = _statusController.text.trim();
        final occupation = _occupationController.text.trim();
        final incomeBand = _incomeBandController.text.trim();

        final result = await kycProvider.updateAdditionalInfo(
          sourceOfIncome,
          employmentStatus,
          occupation,
          incomeBand,
        );

        if (result) {
          pushToWithRoute(
            context,
            CustomRoutes.fadeIn(const UploadFiles()),
          );
        } else {
          AlertToast(context: context).showError(kycProvider.errorMessage ?? 'Error updating additional info');
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    }
  }
}
