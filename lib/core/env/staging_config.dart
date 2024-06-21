import 'package:tedfinance_mobile/core/env/base_config.dart';

class StagingConfig implements BaseConfig {
  String get API_KEY => "BQ3uWoZeql4n2jnSRtuhN9jZqLwCv93gOZqh5th0";

  String get CDN_URL => "https://d3f0n3oggzz6vo.cloudfront.net/";

  String get BASE_URL =>
      "https://iw5ntva5r5.execute-api.af-south-1.amazonaws.com/dev";

  // String get BASE_URL => "https://dev.trybeone.ng";

  String get SMILE_SIGNATURE => "M9i3DzQriM1/mG0dayZ2HUn4JzUtMSkGynEugPcAln0=";
  String get SMILE_TIMESTAMP => "2023-12-05T15:18:51.774Z";
  String get SMILE_ID_URL =>
      "https://testapi.smileidentity.com/v1/id_verification";
  bool get IS_SMILE_PROD => false;
}
