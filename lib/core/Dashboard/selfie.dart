import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/upload_files.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_card.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../providers/kyc_provider.dart';
import '../../shared/navigations/routes/navigation_service.dart';
import '../../shared/util/file_utils.dart';
import '../../shared/util/widgets/appbar.dart';
import '../enums/view_state.dart';
import '../env/utils/alert_toast.dart';
import '../env/utils/colors.dart';
import '../env/utils/string_resources.dart';
import 'drawer/bottom_sheet/root.dart';
import 'kyc_completed.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  File? _selfieImage;
  late KYCProvider kycProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TedTopWidget(
                titleText: StringResources.selfie,
                rightIconOnTap: () {},
              ),
              Center(child: SvgPicture.asset(AssetResources.blackStepperIcon2)),
              20.verticalSpace,

              Text(
                StringResources.kindly_capture_a_clear_selfie,
                style: CustomTextStyles.bodySmallBlack900,
              ),
              30.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: _buildSelfieCard(
                    imageFile: _selfieImage,
                    text: "Upload Identity card back photo",
                    onTap: () {
                      pickImage(ImageSource.camera).then((value) {
                        _selfieImage= value;
                        setState(() {});
                      });
                    },
                    onDelete: () {
                      _selfieImage = null;
                      setState(() {});
                    }),
              ),
              20.verticalSpace,
              InkWell(
                onTap: (){
                  selfieSampleSheet(context: context);
                },
                child: Center(
                  child: RichText(
                    text:   TextSpan(
                      children: [
                        TextSpan(
                          text: 'Check',
                          style: TextStyle(color: AppColors.tedGreyText), // light grey
                        ),
                        const TextSpan(
                          text: ' Samples',
                          style: TextStyle(color: AppColors.primaryButtonColor ), // lavender
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              40.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(
                  onPressed: (){

                    uploadSelfie();


                    // PageNavigator(ctx: context)
                    //     .nextPageOnly(page: const KYCCompleted());
                  },
                  text: 'Submit',
                  radius: 30.r,
                ),
              ),
              40.verticalSpace,
              Center(
                child: Text(StringResources.if_you_re_facing_difficulties,
                    style: CustomTextStyles.bodySmallBlack900.copyWith(color: AppColors.tedLightBlack)
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetResources.faceBookIcon,),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.twitterIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.snapchatIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.instagramIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.linkedinIcon),
                  20.horizontalSpace,
                ],)
            ],
          ),
                ),
              ),
        ));
  }

  Widget _buildSelfieCard({
    VoidCallback? onTap,
    File? imageFile,
    String? text,
    VoidCallback? onDelete,
  }) {
    return Stack(
      children: [
        if (imageFile != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 450.h,
              width: double.infinity,
              child: Image.file(
                imageFile,
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          )
        else
          UploadCard(
              cardHeight: 450.h,
              onTap: onTap!,
              cardWidget: Stack(
                children: [
                  SvgPicture.asset(AssetResources.selfieIcon, height: 300.h, width: 250.w,),
                  Positioned(
                    right: 0,
                    left: 185.w,
                    top: 70.h, // half of the height of the first widget
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(AssetResources.cardSelfieIcon, height: 95.h, width: 70.w,)),
                  ),

                ],
              )
          ),
      ],
    );
  }
  uploadSelfie() async {
    if (_formKey.currentState!.validate()) {
      if (_selfieImage != null) {
        try {
          bool isSuccess = await kycProvider.uploadSelfie(selfieFile: _selfieImage!);
          if (isSuccess) {
            if (kycProvider.kycViewState == ViewState.completed) {
              pushToWithRoute(context, CustomRoutes.fadeIn(const  KYCCompleted()));
            } else {
              AlertToast(context: context).showError(kycProvider.errorMessage);
            }
          } else {
            AlertToast(context: context).showError(kycProvider.errorMessage);
          }
        } catch (e) {
          AlertToast(context: context).showError(e.toString());
        }
      } else {
        AlertToast(context: context).showError('Please upload a selfie');
      }
    } else {
      AlertToast(context: context).showError('Please fill in the required fields');
    }
  }
}

