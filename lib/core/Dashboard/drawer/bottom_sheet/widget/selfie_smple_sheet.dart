import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../root.dart';

class SelfieSampleSheet extends StatefulWidget {
  const SelfieSampleSheet({super.key});

  @override
  State<SelfieSampleSheet> createState() => _SelfieSampleSheetState();
}

class _SelfieSampleSheetState extends State<SelfieSampleSheet> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Padding(
            padding:  EdgeInsets.only(left: 20.w, top: 20.0),
            child: Row(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(AssetResources.closeIcon)),

                90.horizontalSpace,
                Text("Selfie Samples", style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp
                              )
                            ),)
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.verticalSpace,
              Text(
                StringResources.a_photo_will_be,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.tedDeepPurple,
                        fontSize: 13.sp,
                        fontWeight:FontWeight.w600
                    )
                ),
              ),
              Container(
                color: Colors.transparent,
                child: Image.asset(
                  AssetResources.sampleImage,
                ),
              ),
              30.verticalSpace,

              40.verticalSpace,
              Text(
                StringResources.pls_avoid_photo,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.tedDeepPurple,
                        fontSize: 13.sp,
                        fontWeight:FontWeight.w600
                    )
                ),
              ),
              30.verticalSpace,

              40.verticalSpace,
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
        ],
      ),
    );
  }
}