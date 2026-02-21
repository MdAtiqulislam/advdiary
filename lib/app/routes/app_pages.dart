import 'package:get/get.dart';

import '../modules/addOrUpdateCase/bindings/add_or_update_case_binding.dart';
import '../modules/addOrUpdateCase/views/add_or_update_case_view.dart';
import '../modules/addOrUpdateNote/bindings/add_or_update_note_binding.dart';
import '../modules/addOrUpdateNote/views/add_or_update_note_view.dart';
import '../modules/archive/bindings/archive_binding.dart';
import '../modules/archive/views/archive_view.dart';
import '../modules/autoCompleteOtp/bindings/auto_complete_otp_binding.dart';
import '../modules/autoCompleteOtp/views/auto_complete_otp_view.dart';
import '../modules/bkashPayment/bindings/bkash_payment_binding.dart';
import '../modules/bkashPayment/views/bkash_payment_view.dart';
import '../modules/bookDetails/bindings/book_details_binding.dart';
import '../modules/bookDetails/views/book_details_view.dart';
import '../modules/books/bindings/books_binding.dart';
import '../modules/books/views/books_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/caseCategory/bindings/case_category_binding.dart';
import '../modules/caseCategory/views/case_category_view.dart';
import '../modules/caseDetails/bindings/case_details_binding.dart';
import '../modules/caseDetails/views/case_details_view.dart';
import '../modules/caseList/bindings/case_list_binding.dart';
import '../modules/caseList/views/case_list_view.dart';
import '../modules/caseReport/bindings/case_report_binding.dart';
import '../modules/caseReport/views/case_report_view.dart';
import '../modules/cases/bindings/cases_binding.dart';
import '../modules/cases/views/cases_view.dart';
import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/commingSoon/bindings/comming_soon_binding.dart';
import '../modules/commingSoon/views/comming_soon_view.dart';
import '../modules/courtSetting/bindings/court_setting_binding.dart';
import '../modules/courtSetting/views/court_setting_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/faqAndSupport/bindings/faq_and_support_binding.dart';
import '../modules/faqAndSupport/views/faq_and_support_view.dart';
import '../modules/fixedForSetting/bindings/fixed_for_setting_binding.dart';
import '../modules/fixedForSetting/views/fixed_for_setting_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/nextCaseTimeLine/bindings/next_case_time_line_binding.dart';
import '../modules/nextCaseTimeLine/views/next_case_time_line_view.dart';
import '../modules/notes/bindings/notes_binding.dart';
import '../modules/notes/views/notes_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/packages/bindings/packages_binding.dart';
import '../modules/packages/views/packages_view.dart';
import '../modules/paymentReport/bindings/payment_report_binding.dart';
import '../modules/paymentReport/views/payment_report_view.dart';
import '../modules/pendingNextDate/bindings/pending_next_date_binding.dart';
import '../modules/pendingNextDate/views/pending_next_date_view.dart';
import '../modules/privacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/privacyPolicy/views/privacy_policy_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/returnPolicy/bindings/return_policy_binding.dart';
import '../modules/returnPolicy/views/return_policy_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/subscriprtion/bindings/subscriprtion_binding.dart';
import '../modules/subscriprtion/views/subscriprtion_view.dart';
import '../modules/supportToken/bindings/support_token_binding.dart';
import '../modules/supportToken/views/support_token_view.dart';
import '../modules/termsAndConditions/bindings/terms_and_conditions_binding.dart';
import '../modules/termsAndConditions/views/terms_and_conditions_view.dart';
import '../modules/todayCaseList/bindings/today_case_list_binding.dart';
import '../modules/todayCaseList/views/today_case_list_view.dart';
import '../modules/userGuide/bindings/user_guide_binding.dart';
import '../modules/userGuide/views/user_guide_view.dart';
import '../modules/videoList/bindings/video_list_binding.dart';
import '../modules/videoList/views/video_list_view.dart';
import '../modules/videoPlayer/bindings/video_player_binding.dart';
import '../modules/videoPlayer/views/video_player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CASE_LIST,
      page: () => CaseListView(),
      binding: CaseListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_OR_UPDATE_CASE,
      page: () => AddOrUpdateCaseView(),
      binding: AddOrUpdateCaseBinding(),
    ),
    GetPage(
      name: _Paths.NEXT_CASE_DETAILS,
      page: () => CaseDetailsView(),
      binding: CaseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CASE_CATEGORY,
      page: () => CaseCategoryView(),
      binding: CaseCategoryBinding(),
    ),
    GetPage(
      name: _Paths.CASE_REPORT,
      page: () => CaseReportView(),
      binding: CaseReportBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.FAQ_AND_SUPPORT,
      page: () => FaqAndSupportView(),
      binding: FaqAndSupportBinding(),
    ),
    GetPage(
      name: _Paths.NEXT_CASE_TIME_LINE,
      page: () => NextCaseTimeLineView(),
      binding: NextCaseTimeLineBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGES,
      page: () => PackagesView(),
      binding: PackagesBinding(),
    ),
    GetPage(
      name: _Paths.BKASH_PAYMENT,
      page: () => const BkashPaymentView(),
      binding: BkashPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_REPORT,
      page: () => PaymentReportView(),
      binding: PaymentReportBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_TOKEN,
      page: () => SupportTokenView(),
      binding: SupportTokenBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.COURT_SETTING,
      page: () => CourtSettingView(),
      binding: CourtSettingBinding(),
    ),
    GetPage(
      name: _Paths.FIXED_FOR_SETTING,
      page: () => FixedForSettingView(),
      binding: FixedForSettingBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.RETURN_POLICY,
      page: () => ReturnPolicyView(),
      binding: ReturnPolicyBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_LIST,
      page: () => VideoListView(),
      binding: VideoListBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAYER,
      page: () => const VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
    GetPage(
      name: _Paths.USER_GUIDE,
      page: () => UserGuideView(),
      binding: UserGuideBinding(),
    ),
    GetPage(
      name: _Paths.CASES,
      page: () => CasesView(),
      binding: CasesBinding(),
    ),
    GetPage(
      name: _Paths.COMMING_SOON,
      page: () => ComingSoonView(),
      binding: CommingSoonBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_NEXT_DATE,
      page: () => PendingNextDateView(),
      binding: PendingNextDateBinding(),
    ),
    GetPage(
      name: _Paths.TODAY_CASE_LIST,
      page: () => TodayCaseListView(),
      binding: TodayCaseListBinding(),
    ),
    GetPage(
      name: _Paths.COMMENTS,
      page: () => CommentsView(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.NOTES,
      page: () => NotesView(),
      binding: NotesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_OR_UPDATE_NOTE,
      page: () => AddOrUpdateNoteView(),
      binding: AddOrUpdateNoteBinding(),
    ),
    GetPage(
      name: _Paths.BOOKS,
      page: () => BooksView(),
      binding: BooksBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_DETAILS,
      page: () => BookDetailsView(),
      binding: BookDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPRTION,
      page: () => const SubscriprtionView(),
      binding: SubscriprtionBinding(),
    ),
    GetPage(
      name: _Paths.AUTO_COMPLETE_OTP,
      page: () => const AutoCompleteOtpView(),
      binding: AutoCompleteOtpBinding(),
    ),
    GetPage(
      name: _Paths.ARCHIVE,
      page: () =>  ArchiveView(),
      binding: ArchiveBinding(),
    ),
  ];
}
