class APIConstants {
  APIConstants._();

  static const String SIGNUP = 'user/signup';
  static const String VERIFY_SIGNUP = 'otp/verify-create';
  static const String RESEND_OTP = 'otp/resend/verification-otp';
  static const String CREATE_PIN =  'pin/create';
  static const String CREATE_USERNAME =  'user/createusername';
  static const String LOGIN=  'user/login';
  static const String USER_DATA =  'user';

  static const String UPDATE_COUNTRIES = 'kyc/updatedocscountry';
  static const String VERIFY_BVN = 'kyc/validatebvn';
  static const String VERIFY_NIN = 'kyc/validateNin';
  static const String FORGOT_PASSWORD = 'user/forgotpassword';
  static const String UPDATE_BIO = 'kyc/updatebio';
  static const String ADDITIONAL_INFO = 'kyc/updateadditionalbio';
  static const String UPLOAD_DOC = 'userdocument/submitkycdocs';
  static const String UPLOAD_SELFIE = 'userdocument/uploadkycSelfie';
  static const String VERIFY_OTP='otp/verify';
}
