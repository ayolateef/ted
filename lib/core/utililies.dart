import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:uuid/uuid.dart';

class Utilities {
  static String nairaSign = "₦";
  //static String nairaSign = "NGN";
  static String getInitials(String firstName, String lastName) {
    String initials = "";
    initials += firstName.substring(0, 1);
    initials += lastName.substring(0, 1);

    return initials.toUpperCase();
  }

  static String name({firstname, displayName, fullName, String? tag}) {
    if (displayName != null && displayName != "") {
      return displayName;
    }
    if (fullName != "" && fullName != null) {
      return fullName;
    }
    if (firstname != "" && firstname != null) {
      return firstname;
    }

    return "";
  }

  static String quickDateFormat(DateTime dateTime) {
    return "${DateFormat.E().format(dateTime)} ${DateFormat.d().format(dateTime)}  "
        "${DateFormat.MMM().format(dateTime)},  ${DateFormat.Hm().format(dateTime)}";
  }

  static String formatDateToValidate(String date) {
    var data = date.split("-");
    String day = data[0];
    String month = data[1];
    String year = data[2];
    if (day.length < 2) {
      day = "0$day";
    }
    return "$day-$month-$year";
  }

  static String addSlashToExpDate(String text) {
    if (text.length > 3) {
      return "${text[0]}${text[1]}/${text[2]}${text[3]}";
    }

    return "***";
  }

  static String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String result = "$h:$m:$s";

    return result;
  }

  static String addMaskedtoCardNo(String text) {
    if (text.length > 3) {
      return "${text[0]}${text[1]}${text[2]}${text[3]} **** **** ****";
    }

    return "${text} **** **** ****";
  }

  static String generateUniqueTag() {
    return "TRYBE${const Uuid().v4()}";
  }

  // static Future<void> openUpgradeAppLink() async {
  //   if (Platform.isAndroid || Platform.isIOS) {
  //     final appId = Platform.isAndroid
  //         ? 'unshelledconsultancy.trybe_one_mobile'
  //         : 'com.trybeone.trybe';
  //     final url = Uri.parse(
  //       Platform.isAndroid
  //           ? "market://details?id=$appId"
  //           : "https://apps.apple.com/app/id$appId",
  //     );
  //     await launchUrl(
  //       url,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   }
  // }

  static Future<Map<dynamic, dynamic>> appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    return {"version": version, "code": code, "text": "v$version/$code"};
  }

  static String formatIDTypeSmile(String text) {
    if (text == "VOTER_CARD") {
      return "VOTER_ID";
    } else if (text == "INTERNATIONAL_PASSPORT") {
      return "PASSPORT";
    } else if (text == "DRIVER_LICENSE") {
      return "DRIVERS_LICENSE";
    } else if (text == "NIN") {
      return "NATIONAL_ID";
    }

    return text;
  }

  static String dayMonthFormat({required String date}) {
    try {
      if (date.contains(new RegExp(r'[A-Z]'))) {
        if (date.length >= 5) {
          date = date.substring(0, date.length - 4);
        }
        return date;
      }

      var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
      var inputDate = inputFormat.parse("${date} 00:00:00.000000");

      var outputFormat = DateFormat('d MMMM');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return date;
    }
    //
    //return "${DateFormat.d().format(date)}-${DateFormat.M().format(date)}}";
  }

  static String yearDayMonthDashSeperated({required DateTime date}) {
    return "${DateFormat.y().format(date)}-${DateFormat.d().format(date)}-${DateFormat.M().format(date)}";
  }

  static String yearMonthDayDashSeperated({required DateTime date}) {
    return "${DateFormat.y().format(date)}-${DateFormat.M().format(date)}-${DateFormat.d().format(date)}";
  }

  ///convert datetime format to abbrev.month ,day and year
  static String donationDate(DateTime date) {
    return "${DateFormat.MMMM().format(date)} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}";
  }

  static String notificationDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateToCheck = date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    final dayDifference = now.weekday - date.weekday;
    if (now == date) {
      return "Now";
    } else if (aDate == yesterday) {
      return "Yesterday at ${DateFormat.jm().format(date)}";
    }
    // else if (dayDifference.abs() < 7) {
    //   return "${DateFormat.EEEE().format(date)} at ${DateFormat.jm().format(date)}";
    //}
    else {
      final differenceInHours = now.difference(date).inHours;
      if (now.difference(date).inMinutes < 60) {
        return "an hour ago";
      } else if (differenceInHours < 24) {
        return "$differenceInHours hours ago";
      } else {
        return "${DateFormat.MMMM().format(date)} ${DateFormat.d().format(date)} at ${DateFormat.jm().format(date)}";
      }
    }
  }

  ///convert datetime format to day and abbrev.month
  static String conversationDate(DateTime date) {
    return "${DateFormat.MMMM().format(date)} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)} at ${DateFormat.jm().format(date)}";
  }

  ///convert datetime format to hrs
  static String hrsLeft({required DateTime date}) {
    DateTime now = DateTime.now();
    Duration difference = date.difference(now);

    // Check if the expiration date is in the future
    if (difference.isNegative) {
      return 'Expired'; // or handle expired case as needed
    }

    int hoursLeft = difference.inHours;
    if (hoursLeft > 48) {
      int hoursLeft = difference.inDays;
      return '${hoursLeft}days left';
    }
    {
      return '${hoursLeft}hrs left';
    }
  }

  // progress value
  static double calculateRatio({required int count, required int targetValue}) {
    if (targetValue == 0) {
      // Avoid division by zero
      return 0.0;
    }

    return count / targetValue;
  }

  static String dateFormatter(String date) {
    var formatter = DateFormat('yyyy-MM-dd');
    DateTime dateTime = formatter.parse(date);
    String formatted = formatter.format(dateTime);
    var reformatDate = formatted.split("-");
    String formattedDate =
        "${reformatDate[2]}-${reformatDate[1]}-${reformatDate[0]}";

    //print(formattedDate);
    return formattedDate;
  }

  static String formatShareCount(int shareCount) {
    if (shareCount == 0) {
      return "0";
    } else if (shareCount < 1000) {
      return shareCount.toString();
    } else if (shareCount < 1000000) {
      double kValue = shareCount / 1000;
      return '${kValue.toStringAsFixed(1)}k';
    } else if (shareCount < 1000000000) {
      double mValue = shareCount / 1000000;
      return '${mValue.toStringAsFixed(1)}M';
    } else if (shareCount < 1000000000000) {
      double bValue = shareCount / 1000000000;
      return '${bValue.toStringAsFixed(1)}B';
    } else if (shareCount < 1000000000000000) {
      double tValue = shareCount / 1000000000000;
      return '${tValue.toStringAsFixed(1)}T';
    } else {
      return shareCount.toString();
    }
  }

  static String getInitialsFromFullname(String fullname) {
    String initials = "";
    String firstName;
    String lastName;

    List<String> tempNames =
        fullname.split(" ").where((el) => el.isNotEmpty).toList();

    List<String> names = [];
    tempNames.forEach((element) {
      names.add(element);
    });
    if (names.isNotEmpty) {
      firstName = names[0].trim();
      initials += firstName.substring(0, 1);
    }
    if (names.length > 1) {
      lastName = names[1].trim();
      initials += lastName.substring(0, 1);
    }

    return initials.toUpperCase();
  }

  static String? capitalizeText(String text, {bool? eachWord}) {
    if (text.isEmpty) {
      return "";
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      final List<String> list = text.split('');
      list[0] = list[0].toUpperCase();

      if (eachWord == true) {
        for (int i = 1; i < text.length; i++) {
          if (list[i] == ' ') {
            list[i + 1] = list[i + 1].toUpperCase();
          }
        }
      }

      return list.join('');
    }
  }

  static bool isExtensionValid(String path) {
    List list = path.split(".");
    String extension = list[list.length - 1];

    switch (extension) {
      case "txt":
        return true;
      case "xls":
        return true;
      case "xlsx":
        return true;
      default:
        return false;
    }
  }

  // static String cdnBaseUrl(String url) {
  //   if (url.contains("af-south-1.amazonaws")) {
  //     url = url.replaceAll(
  //         Environment().config.S3_URL, Environment().config.CDN_URL);
  //   }
  //   print("cdnurl ${url}");
  //   return url;
  // }

  //e.g 23rd March, 2021
  static String dayWithSuffixMonthAndYear(DateTime date) {
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return DateFormat("d'$suffix' MMMM, y").format(date);
  }

  static String dayMonthInWordsYearDashSeperated(DateTime date) {
    return DateFormat("d-MMM-y").format(date);
  }

  static String dayWithSuffixMonthAndYearr(DateTime date) {
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return DateFormat("d'$suffix' MMM, y").format(date);
  }

  static String yearMonthDay(String date) {
    var reformatDate = date.split("-");
    String formattedDate =
        "${reformatDate[2]}-${reformatDate[1]}-${reformatDate[0]}";
    return formattedDate;
  }

  static bool checkFileSize(File? file) {
    final bytes = file!.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;

    if (mb > 2) {
      return false;
    } else {
      return true;
    }
  }

  static int getFileSize(File? file) {
    final bytes = file!.readAsBytesSync().lengthInBytes;
    int result = bytes ~/ 1024;
    return result;
  }

  ///convert datetime format to Month, Day, Year and time
  static String monthDayYearAndTime(DateTime date) {
    return "${DateFormat.yMMMd().format(date)} ${DateFormat.jm().format(date)}";
  }

  ///convert datetime format to day and abbrev.month
  static String dayAndAbbrevMonth(DateTime date) {
    return "${DateFormat.d().format(date)} ${DateFormat.MMM().format(date)}";
  }

  static String time(DateTime date) {
    return DateFormat.jm().format(date);
  }

  ///initialize date-picker and format date picked
  static Future<DateTime?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1700),
        lastDate: DateTime(2100));
    if (picked != null) {
      return picked;
    }
    return null;
  }

  ///formats large figures(eg 5000 -> 5k
  static String formatFigure({required double largeFigure}) {
    String _formattedNumber = NumberFormat.compact().format(largeFigure);
    return _formattedNumber;
  }

  ///format currency
  static String formatAmount({required double amount}) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    String formattedAmount = oCcy.format(amount);
    return formattedAmount;
  }

  static String addRemoveNairaSymbol(String amount,
      {required bool addNairaDelimter}) {
    String formattedString = amount;

    if (addNairaDelimter) {
      formattedString = "₦${Utilities.formatAmount(amount: double.tryParse(formattedString) ?? 0)}";
    } else {
      if (formattedString.isNotEmpty && formattedString.contains(",")) {
        formattedString = formattedString.replaceAll(RegExp(r','), "");
      }
      if (formattedString.isNotEmpty && formattedString.contains("NGN")) {
        formattedString = formattedString.replaceAll(RegExp(r'NGN '), "");
      }
      if (formattedString.isNotEmpty && formattedString.contains("NGN")) {
        formattedString = formattedString.replaceAll(RegExp(r'NGN'), "");
      }
      if (formattedString.isNotEmpty && formattedString.contains("₦")) {
        formattedString = formattedString.replaceAll(RegExp(r'₦ '), "");
      }
      if (formattedString.isNotEmpty && formattedString.contains("₦")) {
        formattedString = formattedString.replaceAll(RegExp(r'₦'), "");
      }
    }
    return formattedString;
  }

  static String formatPhoneNo(String phoneNo) {
    String formatted = phoneNo.trim();
    formatted = formatted.replaceAll(RegExp(r'-'), "");
    formatted = formatted.replaceAll(RegExp(r' '), "");
    return formatted;
  }

  static String addCountryCode(String phoneNo) {
    String formatted = phoneNo.trim();
    if (formatted.length == 11) {
      return "+234${formatted.substring(1)}";
    }

    return formatted;
  }

  static String phoneNumberWithCountryCode(String phoneNumber) {
    phoneNumber = formatPhoneNo(phoneNumber);

    if (phoneNumber.length <= 11) {
      return phoneNumber;
    }

    List<String> digits = [];
    phoneNumber.characters.forEach((char) {
      digits.add(char);
    });

    int iters = 0;
    int last = digits.length - 1;
    while (iters < 9) {
      last -= 1;
      iters += 1;
    }
    return "0${phoneNumber.substring(last)}";
  }

  static String findAndReplace(String original, String find, String replace) {
    return original.replaceAll(find, replace);
  }

  ///convert datetime format to Month and Year
  static String monthAndYear({required DateTime date}) {
    return DateFormat.yMMM().format(date);
  }

  ///convert datetime format to Month, Day and Year
  static String dateAndTime({required DateTime date}) {
    return DateFormat.yMMMd().format(date);
  }

  static String parseTime(String time) {
    if (int.parse(time.substring(11, 13)) <= 12) {
      return time.substring(11, 16);
    } else {
      return "${int.parse(time.substring(11, 13)) - 12}${time.substring(13, 16)}";
    }
  }

  static Future<int?> sharedPrefUserId() async {
    final prefs = await SharedPreferences.getInstance();
    //final String? token = prefs.getString('token');
    int? id = prefs.getInt('userId');
    return id;
  }

  static String getAmPm(String time) {
    if (int.parse(time.substring(11, 13)) < 12) {
      return "AM";
    } else {
      return "PM";
    }
  }

  ///convert datetime format to Day/Month/Year
  static String dayMonthYear({required DateTime date}) {
    return "${DateFormat.d().format(date)}-${DateFormat.M().format(date)}-${DateFormat.y().format(date)}";
  }

  ///convert datetime format to Day/Month/Year
  static String yearMonthDayFormatter({required DateTime date}) {
    return DateFormat("yyyy-M-d").format(date);
  }

  ///returns the number of days left on user's subscription plan
  static String daysLeft(
      {required DateTime expiryDate, required DateTime paymentDate}) {
    final difference = expiryDate.difference(paymentDate).inDays;
    return difference.toString();
  }

  // static launchURL({required String url}) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  static String getErrorMessage({required String message}) {
    String returningMessage;
    if (message == "Connection failed" ||
        message.toString().contains("Failed host lookup")) {
      returningMessage =
          "Error establishing internet connection. Please try again";
    } else if (message.toString().contains("Future not completed")) {
      returningMessage =
          "Slow internet connection. Please check your internet connection and try again";
    } else if (message == "Internal Server Error") {
      returningMessage = "An error occurred. Please try again";
    } else {
      returningMessage = message;
    }

    return returningMessage;
  }

  static void logoutUnauthenticaedUser(BuildContext context, int code) async {
    // if (code == 401) {
    //   SharedPreferences _prefs = await SharedPreferences.getInstance();
    //   _prefs.remove("authUser");
    //   _prefs.remove("active_child");
    //   _prefs.remove("token");
    //   _prefs.remove("authUserPhoneNo");
    //   _prefs.clear();

    //   Navigator.pushNamedAndRemoveUntil(
    //       context, RoutePaths.userLogin, (r) => false);
    //   return;
    // }
  }

  static String documetTile(String title) {
    if (title == "SIGNATURE") {
      return "Signature";
    } else if (title == "PROFILE_IMAGE") {
      return "Profile Image";
    } else if (title == "UTILITY_BILL") {
      return "Utility Bill";
    } else if (title == "WORK_ID") {
      return "Work Identity";
    } else if (title == "CALLUP_LETTER") {
      return "Callup Letter";
    } else if (title == "STUDENT_IDENTITY") {
      return "Student Identity";
    } else if (title == "ADMISSION_LETTER") {
      return "Admission Letter";
    }

    return title;
  }

  static String dioErrorHandler(DioException e) {
    final dioError = e;
    print("----: ${dioError.type}");
    print("------: ${dioError.response?.statusMessage.toString() ?? ''} ");
    print("------: ${dioError.response?.data.toString() ?? ''} ");
    print("code ------: ${dioError.response?.statusCode?.toString() ?? ''} ");
    try {
      return dioError.response!.data["message"] ?? StringResources.errorMsg;
    } catch (e) {
      return StringResources.errorMsg;
    }

    // switch (dioError.type) {
    //   case DioErrorType.cancel:
    //     return 'Request was cancelled';
    //   case DioErrorType.response:
    //     // return ErrorResponseModel.fromJson(dioError.response!.data).message;
    //     // if(dioError.response!.data.containsKey)
    //     try {
    //       print(dioError.response!.statusCode.toString());
    //       //print("vvbbvb: => : " + dioError.response!.data["message"]);
    //       if (dioError.response!.statusCode == 404) {
    //         return dioError.response!.data["message"] ?? StringResources.errorMsg;
    //       }
    //       if (dioError.response!.statusCode == 502 ||
    //           dioError.response!.statusCode == 500 ||
    //           dioError.response!.statusCode == 504) {
    //         return StringResources.serverErrorMsg;
    //       }
    //       //print(dioError.response!.statusMessage ?? "lfskflsfl");
    //       // print("vvbbvb: => : " + dioError.response!.data["message"]);
    //       print("vvbbvb1: => : " + dioError.response!.data.toString());
    //       return dioError.response!.data["message"] ?? StringResources.errorMsg;
    //     } catch (e) {
    //       return StringResources.errorMsg;
    //     }

    //   case DioErrorType.connectTimeout:
    //     return 'Connection timed out';
    //   case DioErrorType.other:
    //     return StringResources.errorMsg;
    //   case DioErrorType.sendTimeout:
    //     return StringResources.errorMsg;
    //   case DioErrorType.receiveTimeout:
    //     return "Connection timeout, please try again";
    //   default:
    //     return StringResources.errorMsg;
    // }
  }

  static List<FilteringTextInputFormatter> amountTextInputFormatter() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))];
  }

  static String formatUnderscoreName(String data) {
    return data.replaceAll("_", " ").capitalizeFirstLetter();
  }

  static Future<DateTimeRange?> showDateRange(BuildContext context,
      {DateTime? lastDate}) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // the earliest allowable
      lastDate: lastDate ??
          DateTime.now().add(const Duration(days: 365)), // the latest allowable
      currentDate: DateTime.now(),
      saveText: 'Done',
      // builder: (BuildContext context, Widget? w) {
      //   return Theme(
      //     // data: ThemeData(
      //     //   dialogBackgroundColor: TrybeColors().c.modalBg,
      //     //   primaryColor: TrybeColors().c.primaryRed,
      //     //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     //     primary: TrybeColors().c.primaryRedConstant,
      //     //     onPrimary: TrybeColors().c.whiteConstant,
      //     //     onSurface: TrybeColors().c.black,
      //     //     // background: TrybeColors().c.black,
      //     //     // onBackground: TrybeColors().c.black
      //     //   ),
      //     // ),
      //     data: ThemeData.light().copyWith(
      //         appBarTheme: ThemeData.light().appBarTheme.copyWith(
      //             backgroundColor: Colors.blue,
      //             iconTheme: ThemeData.light()
      //                 .appBarTheme
      //                 .icofinTheme!
      //                 .copyWith(color: Colors.white)),
      //         colorScheme: ColorScheme.light(
      //             onPrimary: Colors.white, primary: Colors.red)),
      //     child: w!,
      //   );
      // }
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      print(result.end.toString());
      //setState(() {});
      return result;
    }
    return null;
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isNotEmpty) {
      var splittedStringList = split(" ");
      var newString = "";
      for (var element in splittedStringList) {
        var elementInTitleCase =
            element[0].toUpperCase() + element.substring(1);
        newString = "$newString$elementInTitleCase ";
      }

      return newString.trim();
    } else {
      return "";
    }
  }
}

String? capitalizeText(String text, {bool? eachWord}) {
  if (text.isEmpty) {
    return null;
  } else if (text.length <= 1) {
    return text.toUpperCase();
  } else {
    final List<String> list = text.split('');
    list[0] = list[0].toUpperCase();

    if (eachWord == true) {
      for (int i = 1; i < text.length; i++) {
        if (list[i] == ' ') {
          list[i + 1] = list[i + 1].toUpperCase();
        }
      }
    }

    return list.join('');
  }
}

String stripHtml(String html) {
  return Bidi.stripHtmlIfNeeded(html);
}
