class APIConstants {
  APIConstants._();

  static const String SIGNUP = 'user/signup';
  static const String VERIFY_SIGNUP = 'otp/verify-create';
  static const String RESEND_OTP = 'otp/resend/verification-otp';
  static const String CREATE_PIN =  'pin/create';
  static const String CREATE_USERNAME =  'user/createusername';
  static const String LOGIN=  'user/login';
  static const String USER_DATA =  'user';

  static const String UPDATE_COUNTRIES = 'user/updatedocscountry';
  static const String COUNTRIES = "user/countries";
  static const String VERIFY_BVN = 'kyc/validatebvn';
  static const String SAVE_BVN = 'user/savebvn';

  static const String VERIFY_NIN = 'kyc/validateNin';
  static const String SAVE_NIN = 'user/saveNin';
  static const String FORGOT_PASSWORD = 'user/forgotpassword';
  static const String UPDATE_PASSWORD ="user/updatepassword";
  static const String UPDATE_BIO = 'user/updatebio';
  static const String ADDITIONAL_INFO = 'kyc/updateadditionalbio';
  static const String UPLOAD_DOC = 'userdocument/submitkycdocs';
  static const String UPLOAD_SELFIE = 'userdocument/uploadkycSelfie';
  static const String VERIFY_OTP= 'otp/verify';

  static const String WALLET_INFO = 'wallet';
  static const String KYC_PROGRESS = 'user';
  static const String FCM_TOKEN = 'user/fcm';
  static const String REQUEST_CARD = 'card';
  static const String GET_CARD_DETAILS = 'card';
  static const String FUND_CARD = 'card/fund';
  static const String FREEZE_UNFREEZE = 'card/toggle';
  static const String DELETE_CARD = 'card';
  static const String CURRENT_FX_RATE = 'exchange/current_rate';
  static const String WITHDRAW_FROM_CARD = 'card/withdraw';
  static const String GET_CARD_BALANCE = 'card/balance';
  static const String GET_CARD_TRANSACTIONS = 'card/transactions';

  static const String GET_BANKS = 'transfer/banks';
  static const String USERNAME_LOOKUP = 'transfer/username/lookup';
  static const String  SEND_MONEY_TO_TEDFINANCE_USER = 'transfer/intrabank/username';
  static const String NAME_ENQUIRY = "transfer/nameenquiry";
  static const String OUTWARD_TRANSFER = "transfer/outwardtransfer";




}
