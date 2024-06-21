import 'package:tedfinance_mobile/core/env/base_config.dart';

class DevConfig implements BaseConfig {
  String get API_KEY => "AF1PK_xLLZjhr1be5tFvdxFisJHmds3XZBSq3x9";

      //"BQ3uWoZeql4n2jnSRtuhN9jZqLwCv93gOZqh5th0";

  String get CDN_URL => "https://d3f0n3oggzz6vo.cloudfront.net/";

  String get BASE_URL =>
      //"https://269z8txn0l.execute-api.us-east-1.amazonaws.com/dev/api";
      "http://ec2-50-17-8-125.compute-1.amazonaws.com:3000/api";
  // String get BASE_URL => "https://dev.trybeone.ng";

  String get SMILE_SIGNATURE => "M9i3DzQriM1/mG0dayZ2HUn4JzUtMSkGynEugPcAln0=";
  String get SMILE_TIMESTAMP => "2023-12-05T15:18:51.774Z";
  String get SMILE_ID_URL =>
      "https://testapi.smileidentity.com/v1/id_verification";
  bool get IS_SMILE_PROD => false;
}
