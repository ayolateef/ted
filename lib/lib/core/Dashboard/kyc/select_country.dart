import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';

import '../../../providers/kyc_provider.dart';
import '../../../shared/models/kyc_model/country_model.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import 'kyc_verification.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final TextEditingController _searchController = TextEditingController();
 String _selectedCountry = "";
  late KYCProvider kycProvider;
  List<CountryListModel>? _countries;
  List<CountryListModel>? _suggestions;

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
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      kycProvider = Provider.of<KYCProvider>(context, listen: false);
      final countries = await kycProvider.getCountries();
      setState(() {
        _countries = countries;
        _suggestions = countries;

      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load countries: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          children: [
            TedTopWidget(
              titleText: StringResources.select_country,
              rightIconOnTap: () {
                PageNavigator(ctx: context)
                    .nextPageOnly(page: const KYCVerification());
              },
            ),
            10.verticalSpace,
            Text(StringResources.select_country_where_id_was_issued,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600))),
            25.verticalSpace,
            Expanded(
              child: CustomPaint(
                painter: const GradientBorderPainter(
                  startColor: Color(0xFFE071DF),
                  endColor: Color(0xFF02E4F0),
                  strokeWidth: 2.0, // Adjust border width as needed
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {

                              final searchText = _searchController.text;
                              //final countries = await kycProvider.getCountries();
                              // if(countries != null){
                              //   pushToWithRoute(context, CustomRoutes.fadeIn(
                              //       const KYCVerification()
                              //   ));
                              // }else {
                              //   AlertToast(context: context)
                              //       .showError(kycProvider.errorMessage);
                              // }

                              setState(() {
                                _suggestions = _countries?.where((country) =>
                                country.name?.toLowerCase().contains(searchText.toLowerCase()) ?? false).toList();
                              });
                            },
                            child: SvgPicture.asset(AssetResources.searchIcon),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
                              height: 50.h,
                              padding: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                color: AppColors.tedButtonGrey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextFormField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: AppColors.tedGreyText),
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) async {
                                  final filteredCountries = _countries?.where((country) {
                                    return country.name?.toLowerCase().contains(text.toLowerCase()) ?? false;
                                  }).toList();
                                  setState(() {
                                    _suggestions = filteredCountries;
                                  });
                                },
                                // onChanged: (text) async {
                                //   KYCProvider kycProvider =
                                //   Provider.of<KYCProvider>(context, listen: false);
                                //  // final countries = await kycProvider.getCountries();
                                //   final filteredCountries = countries.where((country) {
                                //     return country.name.toLowerCase().contains(text.toLowerCase());
                                //   }).toList();
                                //
                                //   setState(() {
                                //     _suggestions = filteredCountries;
                                //   });
                                // },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          InkWell(
                              onTap: () async {
                                if (_countries != null) {
                                  _searchController.clear();
                                  setState(() {
                                    _suggestions = _countries;
                                  });
                                }
                              },
                            child: SvgPicture.asset(AssetResources.cancelIcon),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: _suggestions != null && _suggestions!.isNotEmpty
                            ? ListView.builder(
                          itemCount: _suggestions!.length,
                          itemBuilder: (context, index) {
                            final country = _suggestions![index];
                            return ListTile(
                              leading: SizedBox(
                                width: 40,
                                child: SvgPicture.network( country.image ?? '')
                              ),
                              title: Text(country.name ?? ''),
                              onTap: () async {
                                final result = await kycProvider.setCountry(country.name ?? '');
                                if (result != null) {
                                  setState(() {
                                    _selectedCountry = country.name!;
                                  });
                                  pushToWithRoute(context, CustomRoutes.fadeIn(const KYCVerification()));
                                } else {
                                  AlertToast(context: context).showError(kycProvider.errorMessage);
                                }
                              },
                            );
                          },
                        )
                            : const Center(child: Text('No suggestions yet')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_selectedCountry.isNotEmpty) // Display selected country if any
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Selected Country: $_selectedCountry',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
          ),
      ),
    );
  }

  }



class GradientBorderPainter extends CustomPainter {
  final Color startColor;
  final Color endColor;
  final double strokeWidth;

  const GradientBorderPainter({
    required this.startColor,
    required this.endColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [startColor, endColor],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    const double borderRadius = 20.0;
    final path = Path()
      ..addRRect(RRect.fromRectXY(
        Rect.fromLTWH(0, 0, size.width, size.height),
        borderRadius,
        borderRadius,
      ));

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
