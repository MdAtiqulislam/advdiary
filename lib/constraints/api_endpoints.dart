class APIEndPoints {

  //Live url
 static const baseUrl = "https://advdiary.lawsuitbd.com/api";

  //Test url
  //static const baseUrl = "https://papayawhip-elk-647095.hostingersite.com/api";

  static const register="/auth/sign_up";
  static const login="/auth/login";
  static const logOut="/auth/logout";

  static const getOTP="/auth/email-validation-otp";
  static const verifyOTP="/auth/verify_email_otp";
  static const reSendOTP="/auth/email-validation-otp";
  static const getHomeData="/ajax/get_dashboard_data";
  static const getCaseList="/ajax/case_list";
  static const getCategoryList="/ajax/get_categories";
  static const getCaseCategoryList="/ajax/case_category_list";
  static const addCaseEndPoint="/ajax/add_case";
  static const editCaseEndPoint="/ajax/edit_case";
  static const updateCaseEndPoint="/ajax/update_case";
  static const deleteCaseEndPoint="/ajax/delete_case";
  static const getStatusEndPoint="/ajax/get_status_list";
  static const saveNextDateEndPoint="/ajax/add_next_date_case";
  static const getCaseDetailsEndPoint="/ajax/next_date_case_details";
  static const updateNextDateEndPoint="/ajax/update_next_date_case";
  static const addCaseCategoryEndpoint="/ajax/add_case_category";
  static const updateCaseCategoryEndpoint="/ajax/update_case_category";
  static const deleteCaseCategoryEndPoint="/ajax/delete_case_category";
  static const getCourtListEndpoint="/ajax/get_court_list";
  static const getCourtListEndpointNew="/ajax/court_list";
  static const getCourtReportEndPoint="/ajax/court_report";
  static const updateUserProfile="/ajax/update_user_profile";
  static const getFAQEndPoint="/ajax/faq_support";
  static const changePassword="/ajax/user_change_password";
  static const resetPassword="/auth/reset-password";
  static const getNextCasesTimeLine="/ajax/upcoming_all_case_next_date";
  static const getPackageInfo="/ajax/all_package_information";
  static const getPackages="/ajax/all_package_list";
  static const upgradePackage="/bkash/create-payment";
  static const newSubscriber="/bkash/subscriber-payment";
  static const yearlySubscriber="/bkash/yearly-payment";
  static const monthlySubscriber="/bkash/monthly-payment";
  static const upComingCaseDate="/ajax/upcoming_case_next_date";
  static const getPaymentReportEndPoint="/ajax/payment_report";
  static const getTermsAndCondition="/auth/terms-and-condition";
  static const getTermsAndConditionsFile="/ajax/terms_and_conditions";
  static const videoTutorial="/ajax/video_tutorial";
  static const getTokens="/ajax/support_token";
  static const createSupportToken="/ajax/create_support_token";
  static const getDistrict="/auth/get_districts";
  static const deleteCourt="/ajax/delete_court";
  static const addCourt="/ajax/add_court";
  static const editCourt="/ajax/update_court";
  static const getFixedForList="/ajax/fixed_for_list";
  static const getFixedForAllData="/ajax/get_fixed_for";
  static const addFixedFor="/ajax/add_fixed_for";
  static const editFixedFor="/ajax/update_fixed_for";
  static const deleteFixedFor="/ajax/delete_fixed_for";
  static const getThana="/ajax/get_thana_list";
  static const getNotice="/ajax/get_notice";
  static const getReturnPolicy="/ajax/return_policy";
  static const getVideoList="/ajax/video_tutorial_gallery";
  static const getUserGuide="/ajax/project_feature";
  static const getAppBarData="/ajax/app_bar_data";
  static const getPrivacyPolicy="/ajax/privacy_policy";
  static const getPendingNextDate="/ajax/pending_next_date_case_list";
  static const getTodayCaseList="/ajax/today_case_list";
  static const getSupportTokenDetails="/ajax/support_token_comment_details";
  static const addComment="/ajax/add_support_token_comment";
  static const smsStatusChange="/ajax/sms_status_change";
  static const getEvents="/ajax/upcoming_next_date_case_event";
  static const getNotes="/ajax/note_list";
  static const addNote="/ajax/create_notes";
  static const removeNote="/ajax/delete_notes";
  static const updateNote="/ajax/update_notes";
  static const getBooks="/ajax/book_list";
  static const changePasswordOtpVerification="/ajax/change_password_otp_varification";
  static const getArchive="/ajax/archived_case_list";
  static const forceUpdate="/auth/force_update";


}
