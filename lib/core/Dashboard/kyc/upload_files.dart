import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/kyc_verification.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/selfie.dart';
import 'package:tedfinance_mobile/shared/util/get_image.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_card.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/file_utils.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class UploadFiles extends StatefulWidget {
  const UploadFiles({super.key});

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  File? selectedImage;
  bool isHovered = false;
  File? _frontImage;
  File? _backImage;
  File? _utilityBill;
  final TextEditingController _identityCardController = TextEditingController();
  final TextEditingController _identityCardNumController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late KYCProvider kycProvider;

  List<String> typeOfIdentityCard = [
    'International Passport',
    'Drivers License',
    'National Identity Card (NIN)',
    'Cooperate Affairs Commission (CAC)',
  ];
  List<String> uploadFiles = [
    'Take a Picture with Camera'
        'Upload from Gallery'
        'Upload from File'
  ];
  List<String> textFiles = [
    'Upload Identity card front photo'
        'Upload Identity card back photo'
        'Upload Current Utility Bill'
  ];
  Future<bool> onBackPress(context, bool value) {
    return showDialog<bool>(
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
            )) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TedTopWidget(
                titleText: StringResources.upload_files,
                rightIconOnTap: () {},
                trailing: Container(),
              ),
              Center(child: Image.asset(AssetResources.step2)),
              30.verticalSpace,
              const BigPinkContainer(
                text: StringResources.note,
              ),
              40.verticalSpace,
              CustomTextFormField(
                headerText: 'Type of Identity Card',
                textFontSize: 12.sp,
                headerTextFontWeight: FontWeight.w400,
                onChange: (value) {
                  if (value.isEmpty) {
                    setState(() {});
                    _showTypeOfIdentityCard(
                      context,
                      _identityCardController,
                    );
                  }
                },
                hintText: 'Select Type of Identity Card',
                controller: _identityCardController,
                textInputType: TextInputType.text,
                suffix: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => _showTypeOfIdentityCard(
                      context,
                      _identityCardController,
                    ),
                    child: SvgPicture.asset(
                      AssetResources.dropdownIcon,
                      height: 10,
                      width: 10,
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              CustomTextFormField(
                  headerText: 'Identity Card Number',
                  textFontSize: 12.sp,
                  headerTextFontWeight: FontWeight.w400,
                  hintText: 'Enter Identity Card Number',
                  textInputType: TextInputType.number,
                  controller: _identityCardNumController),
              25.verticalSpace,
              SizedBox(
                height: 170.h,
                child: Stack(
                  children: [
                    _buildUploadCard(
                      imageFile: _frontImage,
                      text: "Upload Identity card front photo",
                      onTap: () {
                        // ...
                      },
                      onDelete: () {
                        // ...
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 18.w),
                                height: 400,
                                child: Column(
                                  children: [
                                    Text(
                                      'Upload Files',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    30.verticalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        pickImage(ImageSource.camera)
                                            .then((value) {
                                          _frontImage = value;
                                          setState(() {});
                                         // Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.white2,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                      "Take a picture with Camera",
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)))),
                                            ],
                                          )),
                                    ),
                                    // ListTile(
                                    //   leading: Icon(Icons.camera),
                                    //   title: Text("Take a picture"),
                                    //   onTap: () {
                                    //     pickImage(ImageSource.camera).then((value) {
                                    //       _frontImage = value;
                                    //       setState(() {});
                                    //       Navigator.pop(context);
                                    //     });
                                    //   },
                                    // ),
                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        File? image =
                                            await GetImage.getFromGallery();
                                        if (image != null) {
                                          setState(() {
                                            _frontImage = image;
                                            //Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from gallery",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),

                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        GetImage getImage = GetImage();
                                        File? image =
                                            await getImage.selectFile();
                                        if (image != null) {
                                          setState(() {
                                            _frontImage = image;
                                           // Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from File",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          AssetResources.editImage,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              25.verticalSpace,
              SizedBox(
                height: 170.h,
                child: Stack(
                  children: [
                    _buildUploadCard(
                      imageFile: _backImage,
                      text: "Upload Identity card back photo",
                      onTap: () {
                        // ...
                      },
                      onDelete: () {
                        // ...
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 18.w),
                                height: 400,
                                child: Column(
                                  children: [
                                    Text(
                                      'Upload Files',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    30.verticalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        pickImage(ImageSource.camera)
                                            .then((value) {
                                          _backImage = value;
                                          setState(() {});
                                         // Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.white2,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                      "Take a picture with Camera",
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)))),
                                            ],
                                          )),
                                    ),
                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        File? image =
                                            await GetImage.getFromGallery();
                                        if (image != null) {
                                          setState(() {
                                            _backImage = image;
                                           // Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from gallery",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),
                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        GetImage getImage = GetImage();
                                        File? image =
                                            await getImage.selectFile();
                                        if (image != null) {
                                          setState(() {
                                            _backImage = image;
                                           // Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from File",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          AssetResources.editImage,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              25.verticalSpace,
              SizedBox(
                height: 170.h,
                child: Stack(
                  children: [
                    _buildUploadCard(
                      imageFile: _utilityBill,
                      text: "Upload Current Utility Bill",
                      onTap: () {
                        // ...
                      },
                      onDelete: () {
                        // ...
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 18.w),
                                height: 400,
                                child: Column(
                                  children: [
                                    Text(
                                      'Upload Files',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    30.verticalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        pickImage(ImageSource.camera)
                                            .then((value) {
                                          _utilityBill = value;
                                          setState(() {});
                                         // Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.white2,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                      "Take a picture with Camera",
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)))),
                                            ],
                                          )),
                                    ),
                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        File? image =
                                            await GetImage.getFromGallery();
                                        if (image != null) {
                                          setState(() {
                                            _utilityBill = image;
                                            //Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from gallery",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),
                                    20.verticalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        GetImage getImage = GetImage();
                                        File? image =
                                            await getImage.selectFile();
                                        if (image != null) {
                                          setState(() {
                                            _utilityBill = image;
                                           // Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.white2),
                                        child: Center(
                                            child: Text("Upload from File",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)))),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          AssetResources.editImage,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
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
                    onPressed: () {
                      uploadDocument();
                      //pushToWithRoute(context, CustomRoutes.fadeIn(const SelfieScreen()));
                    },
                    color: isHovered
                        ? AppColors.primaryColor
                        : AppColors.tedButtonGrey,
                    radius: 18.r,
                    text: 'Proceed',
                    height: 52,
                  ),
                ),
              ),
              50.verticalSpace,
              Center(
                child: Text(StringResources.if_you_re_facing_difficulties,
                    style: CustomTextStyles.bodySmallBlack900
                        .copyWith(color: AppColors.tedLightBlack)),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetResources.faceBookIcon,
                  ),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.twitterIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.snapchatIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.instagramIcon),
                  20.horizontalSpace,
                  SvgPicture.asset(AssetResources.linkedinIcon),
                  20.horizontalSpace,
                ],
              )
            ]),
          ),
        ),
      )),
    );
  }

  void _uploadDocuments(
    BuildContext context,
    VoidCallback? onTap,
    String? text,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Upload Files',
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: uploadFiles.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(color: AppColors.white2),
                        child: Center(
                            child: Text(uploadFiles[index],
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600)))))),
              );
            },
          ),
        );
      },
    );
  }

  void _showTypeOfIdentityCard(
      BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Type Of Identity',
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: typeOfIdentityCard.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
                child: InkWell(
                    onTap: () {
                      controller.text = typeOfIdentityCard[index];
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(color: AppColors.white2),
                        child: Center(
                            child: Text(typeOfIdentityCard[index],
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600)))))),
              );
            },
          ),
        );
      },
    );
  }

  uploadDocument() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_frontImage != null && _backImage != null && _utilityBill != null) {
          log('Images are not null');
          bool isSuccess = await kycProvider.uploadDocument(
              documents: [
                DocToSend(file: _frontImage, type: "FRONT_IMAGE"),
                DocToSend(file: _backImage, type: "BACK_IMAGE"),
                DocToSend(file: _utilityBill, type: "UTILITY_BILL"),
              ],
              idType: _identityCardController.text,
              idNumber: _identityCardNumController.text);
          if (isSuccess) {
            pushToWithRoute(context, CustomRoutes.fadeIn(const SelfieScreen()));
          } else {
            AlertToast(context: context).showError(kycProvider.errorMessage);
          }
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    }
  }

  Widget _buildUploadCard({
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
              height: 170.h,
              width: double.infinity,
              child: Image.file(
                imageFile,
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          )
        else
          SizedBox(
            height: 170.h,
            width: double.infinity,
            child: UploadCard(
              text: text ?? 'Upload Identity card front photo ',
              onTap: onTap!,
            ),
          ),
      ],
    );
  }
}

class DocToSend {
  File? file;
  String? type;
  DocToSend({this.file, this.type});
}
