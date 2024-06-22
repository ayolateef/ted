import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/string_resources.dart';
import 'details_who_to_send_to.dart';

class AddFundToWallet extends StatefulWidget {
  const AddFundToWallet({super.key});

  @override
  State<AddFundToWallet> createState() => _AddFundToWalletState();
}

class _AddFundToWalletState extends State<AddFundToWallet> {
   late SmallContainer selectedItem;
  final List<SmallContainer> itemList = [
    const SmallContainer(
      assetImage: AssetResources.nigWhiteFlag2,
      text: "Naira Account (NGN)" ,
    ),
    const SmallContainer(
      assetImage: AssetResources.usWhiteFlag2,
      text: "Dollar Account (USD)" ,
    ),
    const SmallContainer(
      assetImage: AssetResources.poundWhiteFlag2,
      text: "Pounds Account (GBP)" ,
    ),
    const SmallContainer(
      assetImage: AssetResources.euroWhiteFlag2,
      text: "Euro Account (EUR)" ,
    ),



  ];


  @override
  Widget build(BuildContext context) {
    return    PopScope(
      canPop: false,
      child: Scaffold(
          appBar: const TedAppBar(
            elevation: 0,
            titleText: StringResources.add_fund_to_wallet,
          ),
          body: Stack(
            children: [
              Positioned(
                right: -120,
                top: 0,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.purple, // Change color to purple
                      borderRadius:BorderRadius.circular(100.r)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          final item = itemList[index];
                          return  SmallContainer(
                            text:  item.text,
                            assetImage: item.assetImage,
                            onTap: () {
                              setState(() {
                                selectedItem = item;
                              });
                              PageNavigator(ctx: context).nextPage(page:  DetailsFundAccount(selectedItem: selectedItem,));
                            },
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 40.h,);
                      },
                      ),
                    )

                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class SmallContainer extends StatelessWidget {
  final String? assetImage;
  final String? text;
  final Function()? onTap;

  const SmallContainer({
    super.key, this.assetImage, this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GeneralContainer(widget:
      Row(
        children: [
        Image.asset(assetImage ?? ""),
          20.horizontalSpace,
          Text( text ?? " ",
              overflow: TextOverflow.fade,

              style: CustomTextStyles.titleLargeBlack ),
          Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded,)

      ],)),
    );
  }
}
