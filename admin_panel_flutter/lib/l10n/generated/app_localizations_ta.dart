// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'ஃபயர்செஃப்எக்ஸ்';

  @override
  String get navMyModules => 'என் தொகுதிகள்';

  @override
  String get navSettings => 'அமைப்புகள்';

  @override
  String get shellPortalTitle => 'என் வாயில்';

  @override
  String get shellMore => 'மேலும்';

  @override
  String get topbarSignOut => 'வெளியேறு';

  @override
  String get roleUser => 'பயனர்';

  @override
  String get roleManager => 'மேலாளர்';

  @override
  String get roleOrgAdmin => 'நிறுவன நிர்வாகி';

  @override
  String get roleSuperAdmin => 'முதன்மை நிர்வாகி';

  @override
  String get emDash => '—';

  @override
  String get modulesPageTitle => 'என் தொகுதிகள்';

  @override
  String get modulesPageSubtitle =>
      'உங்கள் நிறுவனத்தால் உங்களுக்கு ஒதுக்கப்பட்ட தொகுதிகள்.';

  @override
  String modulesSummaryAssigned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count தொகுதிகள் ஒதுக்கப்பட்டுள்ளன',
      one: '1 தொகுதி ஒதுக்கப்பட்டுள்ளது',
      zero: 'எந்த தொகுதியும் ஒதுக்கப்படவில்லை',
    );
    return '$_temp0';
  }

  @override
  String modulesSummaryOverdue(int count) {
    return '$count தாமதம்';
  }

  @override
  String get moduleTheoryLabel => 'கோட்பாடு';

  @override
  String get moduleTheoryDesc =>
      'கட்டமைக்கப்பட்ட பாடங்கள் மூலம் கருத்துக்கள், செயல்முறைகள் மற்றும் பாதுகாப்பு தரங்களை கற்றுக் கொள்ளுங்கள்.';

  @override
  String get moduleAiExpertLabel => 'AR நிபுணர்';

  @override
  String get moduleAiExpertDesc =>
      'எங்கள் AI உதவியாளரிடம் கேள்விகளைக் கேட்டு உடனடி நிபுணர் வழிகாட்டுதலைப் பெறுங்கள்.';

  @override
  String get moduleSmartTrainingLabel => 'ஸ்மார்ட் பயிற்சி';

  @override
  String get moduleSmartTrainingDesc =>
      'வழிகாட்டப்பட்ட பயிற்சிப் பயிற்சிகள் மற்றும் நிகழ்நேர பின்னூட்டத்துடன் நடைமுறை திறன்களைப் பயிற்சி செய்யுங்கள்.';

  @override
  String get moduleAssessmentLabel => 'மதிப்பீடு';

  @override
  String get moduleAssessmentDesc =>
      'கட்டமைக்கப்பட்ட மதிப்பீடுகள் மூலம் உங்கள் அறிவு மற்றும் திறனைச் சோதிக்கவும்.';

  @override
  String get activityVideos => 'வீடியோக்கள்';

  @override
  String get activityQuizzes => 'வினாடி வினாக்கள்';

  @override
  String get statusNotStarted => 'தொடங்கவில்லை';

  @override
  String get statusInProgress => 'செயலில் உள்ளது';

  @override
  String get statusCompleted => 'நிறைவடைந்தது';

  @override
  String get modulesViewDetails => 'விவரங்களைக் காண்க';

  @override
  String modulesOverdueBanner(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days நாட்கள் தாமதம் — உங்கள் மேலாளரைத் தொடர்பு கொள்ளவும்',
      one: '1 நாள் தாமதம் — உங்கள் மேலாளரைத் தொடர்பு கொள்ளவும்',
    );
    return '$_temp0';
  }

  @override
  String get modulesNoOrgTitle => 'நிறுவனம் ஒதுக்கப்படவில்லை';

  @override
  String get modulesNoOrgDesc =>
      'ஒரு நிறுவனத்திற்கு ஒதுக்க உங்கள் நிர்வாகியைத் தொடர்பு கொள்ளவும்.';

  @override
  String get modulesNoModulesTitle => 'தொகுதிகள் ஒதுக்கப்படவில்லை';

  @override
  String get modulesNoModulesDesc =>
      'உங்கள் மேலாளர் இதுவரை எந்த தொகுதியையும் இயக்கவில்லை.';

  @override
  String get historySectionTitle => 'ஸ்மார்ட் பயிற்சி வரலாறு';

  @override
  String historyAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count முயற்சிகள்',
      one: '1 முயற்சி',
      zero: 'முயற்சிகள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String historyErrorLoading(String error) {
    return 'வரலாற்றை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String get historyPerformanceTrend => 'செயல்திறன் போக்கு';

  @override
  String get historyCriteriaBreakdown => 'அளவுகோல் பகுப்பாய்வு';

  @override
  String historySessionOn(String date) {
    return '$date அன்று அமர்வு';
  }

  @override
  String historyScore(int score) {
    return 'மதிப்பெண்: $score%';
  }

  @override
  String get historyAttemptHistory => 'முயற்சி வரலாறு';

  @override
  String get historyEmptyTitle => 'செயல்திறன் தரவு இல்லை';

  @override
  String get historyEmptyDesc =>
      'உங்கள் முதல் பயிற்சி அமர்வுக்குப் பிறகு காட்சிப்படுத்தல்கள் தோன்றும்.';

  @override
  String get historyViewCertificate => 'சான்றிதழைக் காண்க';

  @override
  String get certificateCourseTitle => 'ஃபயர்செஃப்எக்ஸ் பயிற்சி நிறைவு';

  @override
  String get theoryChaptersTitle => 'கோட்பாட்டு தொகுதிகள்';

  @override
  String get theoryChaptersEmptyTitle =>
      'கோட்பாட்டு அத்தியாயங்கள் எதுவும் கிடைக்கவில்லை';

  @override
  String get theoryChaptersEmptyDesc =>
      'உங்கள் நிறுவனத்திற்கு கோட்பாட்டு உள்ளடக்கம் கட்டமைக்கப்படவில்லை.';

  @override
  String theoryChaptersQuestionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count கேள்விகள்',
      one: '1 கேள்வி',
      zero: 'கேள்விகள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String theoryChaptersErrorLoading(String error) {
    return 'கோட்பாட்டு அத்தியாயங்களை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String get theoryPlayerLoadingVideo => 'வீடியோ ஏற்றப்படுகிறது…';

  @override
  String get theoryPlayerBuffering => 'இடையகப்படுத்துகிறது…';

  @override
  String theoryPlayerBufferedSecs(int seconds) {
    return '$secondsவி இடையகப்படுத்தப்பட்டது';
  }

  @override
  String get theoryPlayerNoVideoUrl => 'வீடியோ URL எதுவும் கிடைக்கவில்லை.';

  @override
  String get theoryPlayerLoadTimeout =>
      'வீடியோ ஏற்ற நீண்ட நேரம் ஆகிறது. உங்கள் இணைப்பைச் சரிபார்க்கவும்.';

  @override
  String theoryPlayerLoadFailed(String error) {
    return 'வீடியோவை ஏற்ற முடியவில்லை: $error';
  }

  @override
  String get theoryPlayerRetry => 'மீண்டும் முயற்சி';

  @override
  String get theoryPlayerTakeQuiz => 'வினாடி வினா எடு';

  @override
  String get theoryPlayerLockedHint =>
      'வினாடி வினாவைத் திறக்க முழு வீடியோவையும் பார்க்கவும்';

  @override
  String get quizTitle => 'தொகுதி வினாடி வினா';

  @override
  String quizQuestionOf(int current, int total) {
    return '$total-இல் கேள்வி $current';
  }

  @override
  String get quizBack => 'பின்';

  @override
  String get quizNext => 'அடுத்து';

  @override
  String get quizFinishQuiz => 'வினாடி வினாவை முடி';

  @override
  String get quizNoQuestions =>
      'இந்த அத்தியாயத்திற்கு கேள்விகள் எதுவும் கிடைக்கவில்லை.';

  @override
  String get quizGoBack => 'திரும்பிச் செல்';

  @override
  String get quizResultPassedTitle => 'வாழ்த்துகள்!';

  @override
  String get quizResultFailedTitle => 'கிட்டத்தட்ட நெருங்கிவிட்டீர்கள்!';

  @override
  String get quizResultPassedDesc =>
      'நீங்கள் கோட்பாட்டு வினாடி வினாவில் தேர்ச்சி பெற்றுள்ளீர்கள்.';

  @override
  String get quizResultFailedDesc =>
      'இந்த தொகுதியில் தேர்ச்சி பெற மீண்டும் முயற்சிக்கவும்.';

  @override
  String get quizResultYourScore => 'உங்கள் மதிப்பெண்';

  @override
  String get quizResultPassed => 'தேர்ச்சி';

  @override
  String get quizResultNotPassed => 'தோல்வி';

  @override
  String get quizBackToCourse => 'பாடத்திற்குத் திரும்பு';

  @override
  String get quizRetryQuiz => 'வினாடி வினாவை மீண்டும் முயற்சி';

  @override
  String get settingsPageTitle => 'அமைப்புகள்';

  @override
  String get settingsPageSubtitle =>
      'கணக்கு விவரங்கள் மற்றும் பாதுகாப்பு அமைப்புகள்.';

  @override
  String get settingsAccountTitle => 'கணக்கு';

  @override
  String get settingsAccountSubtitle => 'உங்கள் சுயவிவர தகவல்';

  @override
  String get settingsSecurityTitle => 'பாதுகாப்பு';

  @override
  String get settingsSecuritySubtitle => 'உங்கள் கடவுச்சொல்லை நிர்வகிக்கவும்';

  @override
  String get settingsSecurityPasswordLabel => 'கடவுச்சொல்';

  @override
  String get settingsSecurityPasswordDesc =>
      'உங்கள் கணக்கின் கடவுச்சொல்லை மாற்றவும்.';

  @override
  String get settingsSecurityChangeBtn => 'கடவுச்சொல்லை மாற்று';

  @override
  String get settingsSecurityUpdateBtn => 'கடவுச்சொல்லைப் புதுப்பி';

  @override
  String get settingsSecurityCurrentPassword => 'தற்போதைய கடவுச்சொல்';

  @override
  String get settingsSecurityNewPassword => 'புதிய கடவுச்சொல்';

  @override
  String get settingsSecurityConfirmPassword =>
      'புதிய கடவுச்சொல்லை உறுதிப்படுத்து';

  @override
  String get settingsSecurityPasswordHint =>
      'கடவுச்சொல் குறைந்தது 6 எழுத்துகளாக இருக்க வேண்டும்.';

  @override
  String get settingsSecurityErrAllRequired => 'அனைத்து புலங்களும் தேவை.';

  @override
  String get settingsSecurityErrMinLength =>
      'புதிய கடவுச்சொல் குறைந்தது 6 எழுத்துகளாக இருக்க வேண்டும்.';

  @override
  String get settingsSecurityErrMismatch => 'கடவுச்சொற்கள் பொருந்தவில்லை.';

  @override
  String get settingsSecurityErrCurrentWrong => 'தற்போதைய கடவுச்சொல் தவறானது.';

  @override
  String get settingsLocaleTitle => 'மொழி மற்றும் பகுதி';

  @override
  String get settingsLocaleSubtitle =>
      'உள்ளடக்கம் உங்களுக்கு எவ்வாறு காட்டப்படும் என்பதைத் தேர்வுசெய்க';

  @override
  String get settingsLocaleLabel => 'மொழி';

  @override
  String get settingsLocaleDesc => 'பகுதி சார்ந்த உள்ளடக்க மாறுபாடு.';

  @override
  String settingsLocaleLoadFailed(String error) {
    return 'மொழிகளை ஏற்ற முடியவில்லை: $error';
  }

  @override
  String get settingsLocaleEmpty =>
      'உங்கள் நிறுவனத்திற்கு மொழிகள் எதுவும் கட்டமைக்கப்படவில்லை.';

  @override
  String get settingsSignOutTitle => 'வெளியேறு';

  @override
  String get settingsSignOutDesc =>
      'இந்தச் சாதனத்தில் உங்கள் கணக்கிலிருந்து வெளியேறு.';

  @override
  String get settingsSignOutBtn => 'வெளியேறு';

  @override
  String commonError(String message) {
    return 'பிழை: $message';
  }

  @override
  String get commonCancel => 'ரத்துசெய்';

  @override
  String get commonClose => 'மூடு';
}
