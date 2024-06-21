
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/personal_bio.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/selfie.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/upload_files.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/models/kyc_model/kyc_progress_model.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import 'bvn.dart';
import 'nin.dart';

enum KYCStatus { APPROVE, PENDING, DECLINED }

class KYCProgress extends StatefulWidget {

   const KYCProgress({
    super.key,
  });

  @override
  State<KYCProgress> createState() => _KYCProgressState();
}

class _KYCProgressState extends State<KYCProgress> {
  bool bvnVerified = false;
  bool bvnPending = false;
  bool selfieVerified = false;
  bool selfiePending = false;
  bool ninVerified = false;
  bool ninPending = false;
  bool idVerified = false;
  bool idPending = false;
  bool addressVerified = false;
  bool addressPending = false;
   KYCProvider? kycProvider;
  KYCProgressModel? kycProgressModel ;


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<KYCProvider>(context, listen: false).getKYCProgress().then((value) {
        setState(() {
          kycProgressModel = value;
        });
      });
    });
  }
  KYCStatus _getKYCStatus(String? status) {
    switch (status) {
      case 'APPROVED':
        return KYCStatus.APPROVE;
      case 'PENDING':
        return KYCStatus.PENDING;
      case 'DECLINED':
      default:
        return KYCStatus.DECLINED;
    }
  }
  List<KYCItem> get kycProgressList {
    return [
      KYCItem(
        title: "Verify your BVN",
        subtitle: "Your BVN has to be verified for you to be\nable to transact",
        status: _getKYCStatus(kycProgressModel?.isKYCVerified),

        type: 'BVN',
        onPressed: () {
          // Verify BVN
        },
      ),
      KYCItem(
        title: "Selfie Verification",
        subtitle:
        "Let us put a real-time face to your name\nto enhance us know you more",
        status:
        _getKYCStatus(kycProgressModel?.isKYCVerified),

        onPressed: () {
          // Verify selfie
        },
        type: 'Selfie',
      ),
      KYCItem(
        title: "Verify Nin",
        subtitle: "Your NIN has to be verified for you to be able\nto transact",
        status: _getKYCStatus(kycProgressModel?.isKYCVerified),

        onPressed: () {
          // Verify NIN
        },
        type: 'NIN',
      ),
      KYCItem(
        title: "ID Validation",
        subtitle: "Your ID has to be verified for you to be\nable to transact",
        status: _getKYCStatus(kycProgressModel?.isKYCVerified),
        onPressed: () {
        },
        type: 'ID',
      ),
      KYCItem(
        title: "Address Verification",
        subtitle:
        "Your address has to be verified with your recent\nUtility bill for you to be able to transact",
        status: _getKYCStatus(kycProgressModel?.isKYCVerified),
        onPressed: () {
          // Verify address
        },
        type: 'Address',
      ),
    ];
  }

  Future<bool?> onBackPress(context, bool value) {
    return showDialog <bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you wish to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => {Navigator.pop(context, false)},
            ),
            TextButton(
                onPressed: () => {Navigator.pop(context, true)},
                child: const Text('Exit'))
          ],
        )
    )  ;
  }

  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Column(
            children: [
              TedTopWidget(
                titleText: StringResources.KYC_Progress,
                rightIconOnTap: () {},
                trailing: Container(),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.grey[65]?.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                  child: SizedBox(
                    // height: 600,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: kycProgressList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: kycProgressList[index],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child:
                                  Divider(height: 1, color: AppColors.grey[65]),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

class KYCItem extends StatefulWidget {
  final String? title;
  final String? type;
  final String? subtitle;
  final KYCStatus? status;
  final VoidCallback? onPressed;

  KYCItem(
      {super.key,
      this.title,
      this.subtitle,
      this.status,
      this.onPressed,
      this.type,

      });

  @override
  State<KYCItem> createState() => _KYCItemState();
}

class _KYCItemState extends State<KYCItem> {
  KYCProgressModel? kycProgressModel;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<KYCProvider>(context, listen: false).getKYCProgress().then((value) {
        setState(() {
          kycProgressModel = value;
        });
      });
    });
  }

  late KYCProvider kycProvider;
  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getStatusColor(widget.status),
          ),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title!,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            10.verticalSpace,
            Text(
              widget.subtitle!,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            15.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getStatusText(widget.status),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: getStatusColor(widget.status),
                    ),
                  ),
                ),
                20.horizontalSpace,
                if (widget.status == KYCStatus.DECLINED)
                  if (widget.type == 'BVN')
                    InkWell(
                      onTap: () {
                        pushToWithRoute(context, CustomRoutes.fadeIn(const BVNPage()));
                      },
                      child: Text(
                        'Verify your BVN',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: getDeclinedColor(),
                          ),
                        ),
                      ),
                    )
                  else if (widget.type == 'NIN')
                    InkWell(
                      onTap: () {
                        pushToWithRoute(context, CustomRoutes.fadeIn(const NINPage()));
                      },
                      child: Text(
                        'Verify your NIN',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: getDeclinedColor(),
                          ),
                        ),
                      ),
                    )
                  else if (widget.type == 'Selfie')
                    InkWell(
                      onTap: () {
                        pushToWithRoute(context, CustomRoutes.fadeIn(const SelfieScreen()));
                      },
                      child: Text(
                        'Click here to upload',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: getDeclinedColor(),
                          ),
                        ),
                      ),
                    )
                  else if (widget.type == 'ID')
                    InkWell(
                      onTap: () {
                        pushToWithRoute(context, CustomRoutes.fadeIn(const UploadFiles()));
                      },
                      child: Text(
                        'Click here to upload',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: getDeclinedColor(),
                          ),
                        ),
                      ),
                    )
                  else if (widget.type == 'Address')
                    InkWell(
                      onTap: () {
                        pushToWithRoute(context, CustomRoutes.fadeIn(const PersonalBio()));
                      },
                      child: Text(
                        'Click here to verify',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: getDeclinedColor(),
                          ),
                        ),
                      ),
                    ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Color getStatusColor(KYCStatus? status) {
    switch (status) {
      case KYCStatus.APPROVE:
        return Colors.green;
      case KYCStatus.PENDING:
        return AppColors.tedYellow2;
      case KYCStatus.DECLINED:
      default:
        return AppColors.tedRed;
    }
  }

  Color getDeclinedColor() {
    return Colors.black;
  }
  String getStatusText(KYCStatus? status) {
    switch (status) {
      case KYCStatus.APPROVE:
        return 'Approved';
      case KYCStatus.PENDING:
        return 'Pending';
      case KYCStatus.DECLINED:
      default:
        return 'Declined';
    }
  }


  Widget getStatusButton(KYCStatus? status, String type) {
    if (status == KYCStatus.DECLINED) {
      switch (type) {
        case 'BVN':
          return TextButton(
            onPressed: () {},
            child: const Text('Verify your BVN'),
          );
        case 'NIN':
          return TextButton(
            onPressed: () {},
            child: const Text('Verify your NIN'),
          );
        case 'Selfie':
          return TextButton(
            onPressed: () {},
            child: const Text('Click here to upload'),
          );
        case 'ID':
          return TextButton(
            onPressed: () {},
            child: const Text('Click here to upload'),
          );
        case 'Address':
          return TextButton(
            onPressed: () {},
            child: const Text('Click here to verify'),
          );
      }
    }
    return Container();
  }
}

