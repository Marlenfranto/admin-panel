import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ta')
  ];

  /// Application title used in the browser tab and OS task switcher.
  ///
  /// In en, this message translates to:
  /// **'FireSafeX'**
  String get appTitle;

  /// No description provided for @navMyModules.
  ///
  /// In en, this message translates to:
  /// **'My Modules'**
  String get navMyModules;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @shellPortalTitle.
  ///
  /// In en, this message translates to:
  /// **'My Portal'**
  String get shellPortalTitle;

  /// No description provided for @shellMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get shellMore;

  /// No description provided for @topbarSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get topbarSignOut;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @roleManager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get roleManager;

  /// No description provided for @roleOrgAdmin.
  ///
  /// In en, this message translates to:
  /// **'Org Admin'**
  String get roleOrgAdmin;

  /// No description provided for @roleSuperAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super Admin'**
  String get roleSuperAdmin;

  /// No description provided for @emDash.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get emDash;

  /// No description provided for @modulesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Modules'**
  String get modulesPageTitle;

  /// No description provided for @modulesPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Modules assigned to you by your organization.'**
  String get modulesPageSubtitle;

  /// Summary chip showing how many modules are assigned to the user.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No modules assigned} =1{1 module assigned} other{{count} modules assigned}}'**
  String modulesSummaryAssigned(int count);

  /// No description provided for @modulesSummaryOverdue.
  ///
  /// In en, this message translates to:
  /// **'{count} overdue'**
  String modulesSummaryOverdue(int count);

  /// No description provided for @moduleTheoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Theory'**
  String get moduleTheoryLabel;

  /// No description provided for @moduleTheoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn concepts, procedures and safety standards through structured lessons.'**
  String get moduleTheoryDesc;

  /// No description provided for @moduleAiExpertLabel.
  ///
  /// In en, this message translates to:
  /// **'AR Expert'**
  String get moduleAiExpertLabel;

  /// No description provided for @moduleAiExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'Ask our AI assistant questions and get instant expert guidance.'**
  String get moduleAiExpertDesc;

  /// No description provided for @moduleSmartTrainingLabel.
  ///
  /// In en, this message translates to:
  /// **'Smart Training'**
  String get moduleSmartTrainingLabel;

  /// No description provided for @moduleSmartTrainingDesc.
  ///
  /// In en, this message translates to:
  /// **'Practice hands-on skills with guided training exercises and real-time feedback.'**
  String get moduleSmartTrainingDesc;

  /// No description provided for @moduleAssessmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get moduleAssessmentLabel;

  /// No description provided for @moduleAssessmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge and competency with structured evaluations.'**
  String get moduleAssessmentDesc;

  /// No description provided for @activityVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get activityVideos;

  /// No description provided for @activityQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get activityQuizzes;

  /// No description provided for @statusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get statusNotStarted;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @modulesViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get modulesViewDetails;

  /// No description provided for @modulesOverdueBanner.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day overdue — contact your manager} other{{days} days overdue — contact your manager}}'**
  String modulesOverdueBanner(int days);

  /// No description provided for @modulesNoOrgTitle.
  ///
  /// In en, this message translates to:
  /// **'No organization assigned'**
  String get modulesNoOrgTitle;

  /// No description provided for @modulesNoOrgDesc.
  ///
  /// In en, this message translates to:
  /// **'Contact your administrator to be assigned to an organization.'**
  String get modulesNoOrgDesc;

  /// No description provided for @modulesNoModulesTitle.
  ///
  /// In en, this message translates to:
  /// **'No modules assigned'**
  String get modulesNoModulesTitle;

  /// No description provided for @modulesNoModulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Your manager has not enabled any modules for you yet.'**
  String get modulesNoModulesDesc;

  /// No description provided for @historySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Training History'**
  String get historySectionTitle;

  /// No description provided for @historyAttempts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No attempts} =1{1 attempt} other{{count} attempts}}'**
  String historyAttempts(int count);

  /// No description provided for @historyErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading history: {error}'**
  String historyErrorLoading(String error);

  /// No description provided for @historyPerformanceTrend.
  ///
  /// In en, this message translates to:
  /// **'Performance Trend'**
  String get historyPerformanceTrend;

  /// No description provided for @historyCriteriaBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Criteria Breakdown'**
  String get historyCriteriaBreakdown;

  /// No description provided for @historySessionOn.
  ///
  /// In en, this message translates to:
  /// **'Session on {date}'**
  String historySessionOn(String date);

  /// No description provided for @historyScore.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}%'**
  String historyScore(int score);

  /// No description provided for @historyAttemptHistory.
  ///
  /// In en, this message translates to:
  /// **'Attempt History'**
  String get historyAttemptHistory;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No performance data'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Visualizations will appear after your first training session.'**
  String get historyEmptyDesc;

  /// No description provided for @historyViewCertificate.
  ///
  /// In en, this message translates to:
  /// **'View Certificate'**
  String get historyViewCertificate;

  /// No description provided for @certificateCourseTitle.
  ///
  /// In en, this message translates to:
  /// **'FireSafeX Training Completion'**
  String get certificateCourseTitle;

  /// No description provided for @theoryChaptersTitle.
  ///
  /// In en, this message translates to:
  /// **'Theory Modules'**
  String get theoryChaptersTitle;

  /// No description provided for @theoryChaptersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No theory chapters available'**
  String get theoryChaptersEmptyTitle;

  /// No description provided for @theoryChaptersEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Theory content has not been configured for your organization.'**
  String get theoryChaptersEmptyDesc;

  /// No description provided for @theoryChaptersQuestionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No Questions} =1{1 Question} other{{count} Questions}}'**
  String theoryChaptersQuestionsCount(int count);

  /// No description provided for @theoryChaptersErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading theory chapters: {error}'**
  String theoryChaptersErrorLoading(String error);

  /// No description provided for @theoryPlayerLoadingVideo.
  ///
  /// In en, this message translates to:
  /// **'Loading video…'**
  String get theoryPlayerLoadingVideo;

  /// No description provided for @theoryPlayerBuffering.
  ///
  /// In en, this message translates to:
  /// **'Buffering…'**
  String get theoryPlayerBuffering;

  /// No description provided for @theoryPlayerBufferedSecs.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s buffered'**
  String theoryPlayerBufferedSecs(int seconds);

  /// No description provided for @theoryPlayerNoVideoUrl.
  ///
  /// In en, this message translates to:
  /// **'No video URL available.'**
  String get theoryPlayerNoVideoUrl;

  /// No description provided for @theoryPlayerLoadTimeout.
  ///
  /// In en, this message translates to:
  /// **'Video is taking too long to load. Check your connection.'**
  String get theoryPlayerLoadTimeout;

  /// No description provided for @theoryPlayerLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video: {error}'**
  String theoryPlayerLoadFailed(String error);

  /// No description provided for @theoryPlayerRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get theoryPlayerRetry;

  /// No description provided for @theoryPlayerTakeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Take Quiz'**
  String get theoryPlayerTakeQuiz;

  /// No description provided for @theoryPlayerLockedHint.
  ///
  /// In en, this message translates to:
  /// **'Watch full video to unlock the quiz'**
  String get theoryPlayerLockedHint;

  /// No description provided for @quizTitle.
  ///
  /// In en, this message translates to:
  /// **'Module Quiz'**
  String get quizTitle;

  /// No description provided for @quizQuestionOf.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String quizQuestionOf(int current, int total);

  /// No description provided for @quizBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get quizBack;

  /// No description provided for @quizNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get quizNext;

  /// No description provided for @quizFinishQuiz.
  ///
  /// In en, this message translates to:
  /// **'Finish Quiz'**
  String get quizFinishQuiz;

  /// No description provided for @quizNoQuestions.
  ///
  /// In en, this message translates to:
  /// **'No questions available for this chapter.'**
  String get quizNoQuestions;

  /// No description provided for @quizGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get quizGoBack;

  /// No description provided for @quizResultPassedTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get quizResultPassedTitle;

  /// No description provided for @quizResultFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Almost there!'**
  String get quizResultFailedTitle;

  /// No description provided for @quizResultPassedDesc.
  ///
  /// In en, this message translates to:
  /// **'You passed the theory quiz.'**
  String get quizResultPassedDesc;

  /// No description provided for @quizResultFailedDesc.
  ///
  /// In en, this message translates to:
  /// **'Try again to pass this module.'**
  String get quizResultFailedDesc;

  /// No description provided for @quizResultYourScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score'**
  String get quizResultYourScore;

  /// No description provided for @quizResultPassed.
  ///
  /// In en, this message translates to:
  /// **'PASSED'**
  String get quizResultPassed;

  /// No description provided for @quizResultNotPassed.
  ///
  /// In en, this message translates to:
  /// **'NOT PASSED'**
  String get quizResultNotPassed;

  /// No description provided for @quizBackToCourse.
  ///
  /// In en, this message translates to:
  /// **'Back to Course'**
  String get quizBackToCourse;

  /// No description provided for @quizRetryQuiz.
  ///
  /// In en, this message translates to:
  /// **'Retry Quiz'**
  String get quizRetryQuiz;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Account details and security settings.'**
  String get settingsPageSubtitle;

  /// No description provided for @settingsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountTitle;

  /// No description provided for @settingsAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile information'**
  String get settingsAccountSubtitle;

  /// No description provided for @settingsSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurityTitle;

  /// No description provided for @settingsSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your password'**
  String get settingsSecuritySubtitle;

  /// No description provided for @settingsSecurityPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsSecurityPasswordLabel;

  /// No description provided for @settingsSecurityPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Change your account password.'**
  String get settingsSecurityPasswordDesc;

  /// No description provided for @settingsSecurityChangeBtn.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsSecurityChangeBtn;

  /// No description provided for @settingsSecurityUpdateBtn.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get settingsSecurityUpdateBtn;

  /// No description provided for @settingsSecurityCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get settingsSecurityCurrentPassword;

  /// No description provided for @settingsSecurityNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get settingsSecurityNewPassword;

  /// No description provided for @settingsSecurityConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get settingsSecurityConfirmPassword;

  /// No description provided for @settingsSecurityPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get settingsSecurityPasswordHint;

  /// No description provided for @settingsSecurityErrAllRequired.
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get settingsSecurityErrAllRequired;

  /// No description provided for @settingsSecurityErrMinLength.
  ///
  /// In en, this message translates to:
  /// **'New password must be at least 6 characters.'**
  String get settingsSecurityErrMinLength;

  /// No description provided for @settingsSecurityErrMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get settingsSecurityErrMismatch;

  /// No description provided for @settingsSecurityErrCurrentWrong.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect.'**
  String get settingsSecurityErrCurrentWrong;

  /// No description provided for @settingsLocaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get settingsLocaleTitle;

  /// No description provided for @settingsLocaleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how content is shown to you'**
  String get settingsLocaleSubtitle;

  /// No description provided for @settingsLocaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Locale'**
  String get settingsLocaleLabel;

  /// No description provided for @settingsLocaleDesc.
  ///
  /// In en, this message translates to:
  /// **'Region-specific content variant.'**
  String get settingsLocaleDesc;

  /// No description provided for @settingsLocaleLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load locales: {error}'**
  String settingsLocaleLoadFailed(String error);

  /// No description provided for @settingsLocaleEmpty.
  ///
  /// In en, this message translates to:
  /// **'No locales configured for your organization.'**
  String get settingsLocaleEmpty;

  /// No description provided for @settingsSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOutTitle;

  /// No description provided for @settingsSignOutDesc.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account on this device.'**
  String get settingsSignOutDesc;

  /// No description provided for @settingsSignOutBtn.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOutBtn;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String commonError(String message);

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
