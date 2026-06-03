// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FireSafeX';

  @override
  String get navMyModules => 'My Modules';

  @override
  String get navSettings => 'Settings';

  @override
  String get shellPortalTitle => 'My Portal';

  @override
  String get shellMore => 'More';

  @override
  String get topbarSignOut => 'Sign out';

  @override
  String get roleUser => 'User';

  @override
  String get roleManager => 'Manager';

  @override
  String get roleOrgAdmin => 'Org Admin';

  @override
  String get roleSuperAdmin => 'Super Admin';

  @override
  String get emDash => '—';

  @override
  String get modulesPageTitle => 'My Modules';

  @override
  String get modulesPageSubtitle =>
      'Modules assigned to you by your organization.';

  @override
  String modulesSummaryAssigned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modules assigned',
      one: '1 module assigned',
      zero: 'No modules assigned',
    );
    return '$_temp0';
  }

  @override
  String modulesSummaryOverdue(int count) {
    return '$count overdue';
  }

  @override
  String get moduleTheoryLabel => 'Theory';

  @override
  String get moduleTheoryDesc =>
      'Learn concepts, procedures and safety standards through structured lessons.';

  @override
  String get moduleAiExpertLabel => 'AR Expert';

  @override
  String get moduleAiExpertDesc =>
      'Ask our AI assistant questions and get instant expert guidance.';

  @override
  String get moduleSmartTrainingLabel => 'Smart Training';

  @override
  String get moduleSmartTrainingDesc =>
      'Practice hands-on skills with guided training exercises and real-time feedback.';

  @override
  String get moduleAssessmentLabel => 'Assessment';

  @override
  String get moduleAssessmentDesc =>
      'Test your knowledge and competency with structured evaluations.';

  @override
  String get activityVideos => 'Videos';

  @override
  String get activityQuizzes => 'Quizzes';

  @override
  String get statusNotStarted => 'Not Started';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get modulesViewDetails => 'View Details';

  @override
  String modulesOverdueBanner(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days overdue — contact your manager',
      one: '1 day overdue — contact your manager',
    );
    return '$_temp0';
  }

  @override
  String get modulesNoOrgTitle => 'No organization assigned';

  @override
  String get modulesNoOrgDesc =>
      'Contact your administrator to be assigned to an organization.';

  @override
  String get modulesNoModulesTitle => 'No modules assigned';

  @override
  String get modulesNoModulesDesc =>
      'Your manager has not enabled any modules for you yet.';

  @override
  String get historySectionTitle => 'Smart Training History';

  @override
  String historyAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts',
      one: '1 attempt',
      zero: 'No attempts',
    );
    return '$_temp0';
  }

  @override
  String historyErrorLoading(String error) {
    return 'Error loading history: $error';
  }

  @override
  String get historyPerformanceTrend => 'Performance Trend';

  @override
  String get historyCriteriaBreakdown => 'Criteria Breakdown';

  @override
  String historySessionOn(String date) {
    return 'Session on $date';
  }

  @override
  String historyScore(int score) {
    return 'Score: $score%';
  }

  @override
  String get historyAttemptHistory => 'Attempt History';

  @override
  String get historyEmptyTitle => 'No performance data';

  @override
  String get historyEmptyDesc =>
      'Visualizations will appear after your first training session.';

  @override
  String get historyViewCertificate => 'View Certificate';

  @override
  String get certificateCourseTitle => 'FireSafeX Training Completion';

  @override
  String get theoryChaptersTitle => 'Theory Modules';

  @override
  String get theoryChaptersEmptyTitle => 'No theory chapters available';

  @override
  String get theoryChaptersEmptyDesc =>
      'Theory content has not been configured for your organization.';

  @override
  String theoryChaptersQuestionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Questions',
      one: '1 Question',
      zero: 'No Questions',
    );
    return '$_temp0';
  }

  @override
  String theoryChaptersErrorLoading(String error) {
    return 'Error loading theory chapters: $error';
  }

  @override
  String get theoryPlayerLoadingVideo => 'Loading video…';

  @override
  String get theoryPlayerBuffering => 'Buffering…';

  @override
  String theoryPlayerBufferedSecs(int seconds) {
    return '${seconds}s buffered';
  }

  @override
  String get theoryPlayerNoVideoUrl => 'No video URL available.';

  @override
  String get theoryPlayerLoadTimeout =>
      'Video is taking too long to load. Check your connection.';

  @override
  String theoryPlayerLoadFailed(String error) {
    return 'Failed to load video: $error';
  }

  @override
  String get theoryPlayerRetry => 'Retry';

  @override
  String get theoryPlayerTakeQuiz => 'Take Quiz';

  @override
  String get theoryPlayerLockedHint => 'Watch full video to unlock the quiz';

  @override
  String get quizTitle => 'Module Quiz';

  @override
  String quizQuestionOf(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get quizBack => 'Back';

  @override
  String get quizNext => 'Next';

  @override
  String get quizFinishQuiz => 'Finish Quiz';

  @override
  String get quizNoQuestions => 'No questions available for this chapter.';

  @override
  String get quizGoBack => 'Go Back';

  @override
  String get quizResultPassedTitle => 'Congratulations!';

  @override
  String get quizResultFailedTitle => 'Almost there!';

  @override
  String get quizResultPassedDesc => 'You passed the theory quiz.';

  @override
  String get quizResultFailedDesc => 'Try again to pass this module.';

  @override
  String get quizResultYourScore => 'Your Score';

  @override
  String get quizResultPassed => 'PASSED';

  @override
  String get quizResultNotPassed => 'NOT PASSED';

  @override
  String get quizBackToCourse => 'Back to Course';

  @override
  String get quizRetryQuiz => 'Retry Quiz';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsPageSubtitle => 'Account details and security settings.';

  @override
  String get settingsAccountTitle => 'Account';

  @override
  String get settingsAccountSubtitle => 'Your profile information';

  @override
  String get settingsSecurityTitle => 'Security';

  @override
  String get settingsSecuritySubtitle => 'Manage your password';

  @override
  String get settingsSecurityPasswordLabel => 'Password';

  @override
  String get settingsSecurityPasswordDesc => 'Change your account password.';

  @override
  String get settingsSecurityChangeBtn => 'Change Password';

  @override
  String get settingsSecurityUpdateBtn => 'Update Password';

  @override
  String get settingsSecurityCurrentPassword => 'Current Password';

  @override
  String get settingsSecurityNewPassword => 'New Password';

  @override
  String get settingsSecurityConfirmPassword => 'Confirm New Password';

  @override
  String get settingsSecurityPasswordHint =>
      'Password must be at least 6 characters.';

  @override
  String get settingsSecurityErrAllRequired => 'All fields are required.';

  @override
  String get settingsSecurityErrMinLength =>
      'New password must be at least 6 characters.';

  @override
  String get settingsSecurityErrMismatch => 'Passwords do not match.';

  @override
  String get settingsSecurityErrCurrentWrong =>
      'Current password is incorrect.';

  @override
  String get settingsLocaleTitle => 'Language & Region';

  @override
  String get settingsLocaleSubtitle => 'Choose how content is shown to you';

  @override
  String get settingsLocaleLabel => 'Locale';

  @override
  String get settingsLocaleDesc => 'Region-specific content variant.';

  @override
  String settingsLocaleLoadFailed(String error) {
    return 'Failed to load locales: $error';
  }

  @override
  String get settingsLocaleEmpty =>
      'No locales configured for your organization.';

  @override
  String get settingsSignOutTitle => 'Sign Out';

  @override
  String get settingsSignOutDesc => 'Sign out of your account on this device.';

  @override
  String get settingsSignOutBtn => 'Sign Out';

  @override
  String commonError(String message) {
    return 'Error: $message';
  }

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';
}
