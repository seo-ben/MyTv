import '/extentions/custom_extentions.dart';

class ApiEndpoint {
  static String mainDomain = "https://mytelevision.world";
  static String baseUrl = "$mainDomain/api/v1";

  //-> Login
  static String loginURL = '/login'.addBaseURl();

  //-> Forgot Password
  static String forgotPasswordSendOtpURL = '/password/forgot/find/user'
      .addBaseURl();
  static String forgotOtpVerifyURL = '/password/forgot/verify/code'
      .addBaseURl();
  static String resetPasswordURL = '/password/forgot/reset'.addBaseURl();

  static String kycSubmitURL = '/authorize/kyc/submit'.addBaseURl();
  static String resendOtpCodeURL = '/password/forgot/resend/code?token='
      .addBaseCustomURl();

  //-> Register
  static String registerURL = '/register'.addBaseURl();
  static String languagesURL = '/settings/languages'.addBaseCustomURl();
  static String registerOtpVerifyURL = '/authorize/mail/verify/code'
      .addBaseURl();
  static String registerOtpResendURL = '/authorize/mail/resend/code?token='
      .addBaseCustomURl();
  static String registerSmsCodeVerifyURL = '/sms/otp/verify'.addBaseURl();
  static String registerSmsCodeResendURL = '/sms/resend/code'.addBaseURl();
  static String logOutURL = '/user/logout'.addBaseURl();

  //-> Profile
  static String profileInfoGetURL = '/user/profile/info'.addBaseURl();
  static String profileUpdateURL = '/user/profile/info/update'.addBaseURl();
  static String profileDeleteURL = '/user/profile/delete'.addBaseURl();
  static String passwordUpdateURL = '/profile/password/update'.addBaseURl();
  static String addMoneyManualPaymentSubmit = '/user/add-money/manual/submit'
      .addBaseURl();

  //-> Change password
  static String changePasswordURL = '/user/profile/password/update'
      .addBaseURl();

  static String basicSettingsURL = '/settings/basic-settings'
      .addBaseCustomURl();

  /// Two fa
  static String twoFaGetURL = '/authorize/google/2fa/status'.addBaseCustomURl();
  static String twoFaSubmitURL = '/authorize/google/2fa/status-update'
      .addBaseURl();
  static String twoFaOtoVerifyURL = '/authorize/google/2fa/verify'.addBaseURl();

  static String transactionUrl = '/user/transaction/log'.addBaseURl();
    // Use the watchlist route that accepts the ID as a path parameter
    static String watchListAddURL = '/home/watchlist/'.addBaseCustomURl();
  static String dashboardURL = "/user/dashboard".addBaseURl();

  ///video services
  static String highlightVideosURL = "/home/highlights/sports".addBaseURl();
  static String homeURL = "/home/index".addBaseCustomURl();
  static String subscriptionURL = "/home/subscription".addBaseCustomURl();
  static String liveVideosURL = "/home/live/sports".addBaseURl();
  static String watchListVideosURL = "/home/watchlist/view".addBaseURl();
  static String watchListDetailsURL = "/home/category/details"
      .addBaseCustomURl();
  static String footballDetailsURL = "/home/details".addBaseCustomURl();
  static String subscriptionPageURL = "/home/subscribe".addBaseURl();
  static String paymentInfoURL = "/user/add-money/payment-gateways"
      .addBaseURl();

  static String paymentAutomaticSubmitURL = "/user/add-money/automatic/submit"
      .addBaseURl();
  static String paymentCheckoutApi = "/home/checkout".addBaseURl();
  static String checkoutURL = "/home/checkout".addBaseURl();
  static String watchlistDeleteURL = "/home/watchlist/delete"
      .addBaseCustomURl();

  static String admobURL = "/settings/admob-credentials".addBaseCustomURl();
  static String recentViewsURL = "/user/recent".addBaseURl();
  static String authorizeConfirm =
      "/user/add-money/payment/authorize-payment-submit".addBaseURl();

  //-> Custom Advertisements
  static String getAdvertisements = "/advertisements".addBaseURl();
  static String recordAdView = "/advertisements/".addBaseURl(); // + {id}/view
  static String recordAdClick = "/advertisements/".addBaseURl(); // + {id}/click
}
