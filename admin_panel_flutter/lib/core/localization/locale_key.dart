/// Canonical locale identifier in the form `REGION-language`.
///
/// `REGION` is ISO-3166 alpha-2 (uppercase). `language` is BCP-47 (lowercase,
/// 2–3 letters). Example: `US-en`, `UK-en`, `AE-ar`.
class LocaleKey {
  static final RegExp _re = RegExp(r'^[A-Z]{2}-[a-z]{2,3}$');
  static const String systemDefault = 'US-en';

  final String value;
  const LocaleKey._(this.value);

  factory LocaleKey.parse(String raw) {
    if (!_re.hasMatch(raw)) {
      throw FormatException('Invalid locale key: "$raw"');
    }
    return LocaleKey._(raw);
  }

  static String? tryNormalize(String? raw) {
    if (raw == null) return null;
    return _re.hasMatch(raw) ? raw : null;
  }

  static bool isValid(String raw) => _re.hasMatch(raw);

  String get regionCode => value.substring(0, 2);
  String get languageCode => value.substring(3);

  static String compose(String region, String language) =>
      '${region.toUpperCase()}-${language.toLowerCase()}';

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LocaleKey && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
