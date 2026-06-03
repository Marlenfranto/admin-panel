// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'فاير سيف إكس';

  @override
  String get navMyModules => 'وحداتي';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get shellPortalTitle => 'بوابتي';

  @override
  String get shellMore => 'المزيد';

  @override
  String get topbarSignOut => 'تسجيل الخروج';

  @override
  String get roleUser => 'مستخدم';

  @override
  String get roleManager => 'مدير';

  @override
  String get roleOrgAdmin => 'مسؤول المؤسسة';

  @override
  String get roleSuperAdmin => 'مسؤول رئيسي';

  @override
  String get emDash => '—';

  @override
  String get modulesPageTitle => 'وحداتي';

  @override
  String get modulesPageSubtitle => 'الوحدات المُخصّصة لك من قِبل مؤسستك.';

  @override
  String modulesSummaryAssigned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وحدة مُخصّصة',
      many: '$count وحدة مُخصّصة',
      few: '$count وحدات مُخصّصة',
      two: 'وحدتان مُخصّصتان',
      one: 'وحدة واحدة مُخصّصة',
      zero: 'لا توجد وحدات مُخصّصة',
    );
    return '$_temp0';
  }

  @override
  String modulesSummaryOverdue(int count) {
    return '$count متأخر';
  }

  @override
  String get moduleTheoryLabel => 'النظرية';

  @override
  String get moduleTheoryDesc =>
      'تعلّم المفاهيم والإجراءات ومعايير السلامة من خلال دروس منظمة.';

  @override
  String get moduleAiExpertLabel => 'خبير الواقع المعزز';

  @override
  String get moduleAiExpertDesc =>
      'اطرح الأسئلة على مساعدنا الذكي واحصل على إرشاد خبير فوري.';

  @override
  String get moduleSmartTrainingLabel => 'التدريب الذكي';

  @override
  String get moduleSmartTrainingDesc =>
      'تدرّب على المهارات العملية من خلال تمارين موجّهة وتغذية راجعة فورية.';

  @override
  String get moduleAssessmentLabel => 'التقييم';

  @override
  String get moduleAssessmentDesc =>
      'اختبر معرفتك وكفاءتك من خلال تقييمات منظمة.';

  @override
  String get activityVideos => 'مقاطع فيديو';

  @override
  String get activityQuizzes => 'اختبارات';

  @override
  String get statusNotStarted => 'لم يبدأ';

  @override
  String get statusInProgress => 'قيد التنفيذ';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get modulesViewDetails => 'عرض التفاصيل';

  @override
  String modulesOverdueBanner(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'متأخر بـ $days يومًا — تواصل مع مديرك',
      many: 'متأخر بـ $days يومًا — تواصل مع مديرك',
      few: 'متأخر بـ $days أيام — تواصل مع مديرك',
      two: 'متأخر بيومين — تواصل مع مديرك',
      one: 'متأخر بيوم واحد — تواصل مع مديرك',
      zero: 'متأخر — تواصل مع مديرك',
    );
    return '$_temp0';
  }

  @override
  String get modulesNoOrgTitle => 'لم يتم تعيين مؤسسة';

  @override
  String get modulesNoOrgDesc => 'تواصل مع المسؤول لتعيينك إلى مؤسسة.';

  @override
  String get modulesNoModulesTitle => 'لم يتم تعيين وحدات';

  @override
  String get modulesNoModulesDesc => 'لم يقم مديرك بتفعيل أي وحدات لك بعد.';

  @override
  String get historySectionTitle => 'سجل التدريب الذكي';

  @override
  String historyAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count محاولة',
      many: '$count محاولة',
      few: '$count محاولات',
      two: 'محاولتان',
      one: 'محاولة واحدة',
      zero: 'لا توجد محاولات',
    );
    return '$_temp0';
  }

  @override
  String historyErrorLoading(String error) {
    return 'خطأ في تحميل السجل: $error';
  }

  @override
  String get historyPerformanceTrend => 'اتجاه الأداء';

  @override
  String get historyCriteriaBreakdown => 'تفصيل المعايير';

  @override
  String historySessionOn(String date) {
    return 'جلسة بتاريخ $date';
  }

  @override
  String historyScore(int score) {
    return 'النتيجة: $score٪';
  }

  @override
  String get historyAttemptHistory => 'سجل المحاولات';

  @override
  String get historyEmptyTitle => 'لا توجد بيانات أداء';

  @override
  String get historyEmptyDesc =>
      'ستظهر الرسوم البيانية بعد جلسة التدريب الأولى.';

  @override
  String get historyViewCertificate => 'عرض الشهادة';

  @override
  String get certificateCourseTitle => 'إنجاز تدريب فاير سيف إكس';

  @override
  String get theoryChaptersTitle => 'وحدات النظرية';

  @override
  String get theoryChaptersEmptyTitle => 'لا توجد فصول نظرية متاحة';

  @override
  String get theoryChaptersEmptyDesc => 'لم يتم إعداد المحتوى النظري لمؤسستك.';

  @override
  String theoryChaptersQuestionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سؤالًا',
      many: '$count سؤالًا',
      few: '$count أسئلة',
      two: 'سؤالان',
      one: 'سؤال واحد',
      zero: 'لا توجد أسئلة',
    );
    return '$_temp0';
  }

  @override
  String theoryChaptersErrorLoading(String error) {
    return 'خطأ في تحميل الفصول النظرية: $error';
  }

  @override
  String get theoryPlayerLoadingVideo => 'جارٍ تحميل الفيديو…';

  @override
  String get theoryPlayerBuffering => 'جارٍ التخزين المؤقت…';

  @override
  String theoryPlayerBufferedSecs(int seconds) {
    return 'تم تخزين $seconds ث';
  }

  @override
  String get theoryPlayerNoVideoUrl => 'لا يتوفر رابط للفيديو.';

  @override
  String get theoryPlayerLoadTimeout =>
      'يستغرق الفيديو وقتًا طويلًا للتحميل. تحقّق من اتصالك.';

  @override
  String theoryPlayerLoadFailed(String error) {
    return 'فشل تحميل الفيديو: $error';
  }

  @override
  String get theoryPlayerRetry => 'إعادة المحاولة';

  @override
  String get theoryPlayerTakeQuiz => 'ابدأ الاختبار';

  @override
  String get theoryPlayerLockedHint => 'شاهد الفيديو بالكامل لفتح الاختبار';

  @override
  String get quizTitle => 'اختبار الوحدة';

  @override
  String quizQuestionOf(int current, int total) {
    return 'السؤال $current من $total';
  }

  @override
  String get quizBack => 'السابق';

  @override
  String get quizNext => 'التالي';

  @override
  String get quizFinishQuiz => 'إنهاء الاختبار';

  @override
  String get quizNoQuestions => 'لا توجد أسئلة متاحة لهذا الفصل.';

  @override
  String get quizGoBack => 'العودة';

  @override
  String get quizResultPassedTitle => 'تهانينا!';

  @override
  String get quizResultFailedTitle => 'أوشكت على النجاح!';

  @override
  String get quizResultPassedDesc => 'لقد اجتزت اختبار النظرية.';

  @override
  String get quizResultFailedDesc => 'حاول مرة أخرى لاجتياز هذه الوحدة.';

  @override
  String get quizResultYourScore => 'نتيجتك';

  @override
  String get quizResultPassed => 'ناجح';

  @override
  String get quizResultNotPassed => 'غير ناجح';

  @override
  String get quizBackToCourse => 'العودة إلى الدورة';

  @override
  String get quizRetryQuiz => 'إعادة الاختبار';

  @override
  String get settingsPageTitle => 'الإعدادات';

  @override
  String get settingsPageSubtitle => 'تفاصيل الحساب وإعدادات الأمان.';

  @override
  String get settingsAccountTitle => 'الحساب';

  @override
  String get settingsAccountSubtitle => 'معلومات ملفك الشخصي';

  @override
  String get settingsSecurityTitle => 'الأمان';

  @override
  String get settingsSecuritySubtitle => 'إدارة كلمة المرور';

  @override
  String get settingsSecurityPasswordLabel => 'كلمة المرور';

  @override
  String get settingsSecurityPasswordDesc => 'غيّر كلمة مرور حسابك.';

  @override
  String get settingsSecurityChangeBtn => 'تغيير كلمة المرور';

  @override
  String get settingsSecurityUpdateBtn => 'تحديث كلمة المرور';

  @override
  String get settingsSecurityCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get settingsSecurityNewPassword => 'كلمة المرور الجديدة';

  @override
  String get settingsSecurityConfirmPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get settingsSecurityPasswordHint =>
      'يجب أن تتكون كلمة المرور من ٦ أحرف على الأقل.';

  @override
  String get settingsSecurityErrAllRequired => 'جميع الحقول مطلوبة.';

  @override
  String get settingsSecurityErrMinLength =>
      'يجب ألا تقل كلمة المرور الجديدة عن ٦ أحرف.';

  @override
  String get settingsSecurityErrMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get settingsSecurityErrCurrentWrong =>
      'كلمة المرور الحالية غير صحيحة.';

  @override
  String get settingsLocaleTitle => 'اللغة والمنطقة';

  @override
  String get settingsLocaleSubtitle => 'اختر كيف يُعرض المحتوى لك';

  @override
  String get settingsLocaleLabel => 'اللغة';

  @override
  String get settingsLocaleDesc => 'متغيّر محتوى خاص بالمنطقة.';

  @override
  String settingsLocaleLoadFailed(String error) {
    return 'فشل تحميل اللغات: $error';
  }

  @override
  String get settingsLocaleEmpty => 'لا توجد لغات مُعدّة لمؤسستك.';

  @override
  String get settingsSignOutTitle => 'تسجيل الخروج';

  @override
  String get settingsSignOutDesc => 'تسجيل الخروج من حسابك على هذا الجهاز.';

  @override
  String get settingsSignOutBtn => 'تسجيل الخروج';

  @override
  String commonError(String message) {
    return 'خطأ: $message';
  }

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonClose => 'إغلاق';
}
