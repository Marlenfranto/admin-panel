# Localization & RTL Architecture

This document describes how multilingual content and RTL/LTR layout are
implemented in the User-role Admin Panel (the `UserShell` surface of the
Flutter client). It covers the runtime architecture, the contributor
workflow for adding strings, the workflow for adding a new locale, and the
RTL behaviors you must respect when authoring new UI.

> **Scope.** This implementation localizes the `UserShell` surface — the User
> portal screens (`UserModulesScreen`, `UserSettingsScreen`, `TheoryChaptersScreen`,
> `TheoryPlayerScreen`, `TheoryQuizView`) and the shared widgets they depend
> on (`AccountSettingsPage`, `DashboardShell`, `TrainingHistoryPanel`).
> Admin / OrgAdmin / Manager shells remain English-only for now; the same
> pattern extends to them when needed.

---

## Table of Contents

1. [Two layers of localization](#two-layers-of-localization)
2. [Locale key model](#locale-key-model)
3. [Runtime architecture](#runtime-architecture)
4. [UI strings (`AppLocalizations`, ARB files)](#ui-strings)
5. [Content strings (server-side resolution)](#content-strings)
6. [RTL support](#rtl-support)
7. [Adding a new translation key](#adding-a-new-translation-key)
8. [Adding a new locale](#adding-a-new-locale)
9. [Testing](#testing)
10. [Known limitations](#known-limitations)

---

## Two layers of localization

The system has two independent layers that share a single "active locale"
state but are stored and resolved separately.

| Layer | What it covers | Source of truth | Resolved by |
|-------|----------------|-----------------|-------------|
| **UI strings** | Buttons, labels, menu items, validation messages, empty states | `lib/l10n/app_<lang>.arb` files compiled into `AppLocalizations` | `AppLocalizations.of(context)` |
| **Content strings** | Theory chapters, training parameters, assessment parameters, assets, AR Expert AI prompt, quiz questions | Per-org `*Localization` tables on the server; embedded `translations` lists in models | `LocaleResolver.firstMatch` (client) / `LocaleResolver.resolveChain` (server) |

A single Riverpod provider, `currentLocaleProvider`, holds the active
locale key (e.g. `AE-ar`). Both layers read from it.

## Locale key model

A canonical **locale key** is `REGION-language` — `^[A-Z]{2}-[a-z]{2,3}$`.

| Locale key | Region | Language | Direction |
|-----------|--------|----------|-----------|
| `US-en`   | `US`   | `en`     | LTR       |
| `UK-en`   | `UK`   | `en`     | LTR       |
| `AE-ar`   | `AE`   | `ar`     | **RTL**   |
| `IN-ta`   | `IN`   | `ta`     | LTR       |

- The **region** lets different markets use different content variants of
  the same language (`US-en` vs `UK-en`). Both share the same UI strings.
- The **language** drives UI ARB lookup (`app_en.arb`, `app_ar.arb`, …).
- `LocaleKey` (`lib/core/localization/locale_key.dart`) validates and parses
  these strings.

## Runtime architecture

```text
┌────────────────────────────────────────────────────────────────────┐
│  user picks a locale (settings drop-down) OR logs in              │
└────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
                ┌───────────────────────────────┐
                │ currentLocaleProvider         │  ← String "AE-ar"
                │ (StateNotifierProvider)       │
                └───────────────────────────────┘
                                │
                ┌───────────────┴───────────────┐
                ▼                               ▼
   ┌─────────────────────────┐    ┌─────────────────────────────┐
   │ UiLocaleResolver        │    │ LocaleResolver (content)    │
   │   .fromLocaleKey(...)   │    │   .resolveChain(...)        │
   │                         │    │   .firstMatch(...)          │
   │ "AE-ar" → Locale(ar,AE) │    │ "AE-ar" → ["AE-ar","US-en"] │
   └─────────────────────────┘    └─────────────────────────────┘
                │                               │
                ▼                               ▼
   ┌─────────────────────────┐    ┌─────────────────────────────┐
   │ MaterialApp.router      │    │ Server *Localized endpoints │
   │  locale: <Locale>       │    │  + embedded translations    │
   │  → AppLocalizations     │    │   (LocalizedQuizContent,…)  │
   │  → Directionality.rtl   │    │                             │
   └─────────────────────────┘    └─────────────────────────────┘
```

### `currentLocaleProvider`

Holds the active **locale key** as a `String`. On bootstrap it resolves in
this order:

1. `AppUser.preferredLocaleKey` (server preference) — authoritative once
   logged in.
2. `SharedPreferences` cached value (offline / pre-login).
3. `LocaleKey.systemDefault` (`US-en`).

`CurrentLocaleNotifier.set(key)` validates the key format, writes to
`SharedPreferences`, updates state, then calls
`user.setPreferredLocale(key)` to sync to the server.

### `UiLocaleResolver`

`lib/core/localization/ui_locale_resolver.dart`. Bridges the project's
regional locale keys to Flutter `Locale` objects:

- `fromLocaleKey("AE-ar")` → `Locale("ar", "AE")`
- `isRtlLanguage("ar")` → `true` (set is `ar`, `fa`, `he`, `iw`, `ps`, `sd`, `ur`)
- `textDirectionFor("AE-ar")` → `TextDirection.rtl`

`MaterialApp.router` reads `currentLocaleProvider`, converts it via
`UiLocaleResolver.fromLocaleKey`, and sets `MaterialApp.locale`. Flutter
applies the right `Directionality` automatically based on the locale
language code (it ships with a built-in RTL list).

### `supportedLocalesProvider`

`lib/core/localization/locale_providers.dart`. Returns the org's enabled
`LocaleConfig` rows from `user.getMyLocales()` — this is the dynamic
catalog rendered in the Settings → Language & Region drop-down. Adding a
new locale on the server makes it appear in the picker on next load — no
client release.

## UI strings

### ARB files (`lib/l10n/`)

- `app_en.arb` — **template** (the `arb-dir`/`template-arb-file` in
  `l10n.yaml`). Adding a key here is the source of truth.
- `app_ar.arb` — Arabic translations.
- `app_ta.arb` — Tamil translations.

ARB format:

```json
{
  "@@locale": "en",
  "modulesSummaryAssigned": "{count, plural, =0{No modules assigned} =1{1 module assigned} other{{count} modules assigned}}",
  "@modulesSummaryAssigned": {
    "description": "Summary chip showing how many modules are assigned to the user.",
    "placeholders": { "count": { "type": "int" } }
  }
}
```

- Keys are camelCase.
- ICU plural / select forms work as in standard ARB.
- Each placeholder needs a typed declaration in the `@-prefixed` metadata.
- Arabic uses the full CLDR plural categories — `zero`, `one`, `two`,
  `few`, `many`, `other`.

### `l10n.yaml`

Drives the gen_l10n tool:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/l10n/generated
nullable-getter: false
```

The `nullable-getter: false` setting means `AppLocalizations.of(context)`
returns a non-nullable value — usage stays terse: `t.navMyModules` rather
than `t!.navMyModules`.

### Wiring (`main.dart`)

```dart
return MaterialApp.router(
  title: 'FireSafeX',
  onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
  locale: UiLocaleResolver.fromLocaleKey(localeKey),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  routerConfig: router,
);
```

`Global*Localizations.delegate` are required so Flutter's built-in Material
widgets (date pickers, time pickers, default tooltip text, Cupertino
controls, etc.) come in the right language too.

### Using a string in a screen

```dart
@override
Widget build(BuildContext context) {
  final t = AppLocalizations.of(context);
  return Text(t.modulesPageTitle);
}
```

For plurals/placeholders:

```dart
t.modulesSummaryAssigned(enabledModules.length)   // ICU plural
t.commonError(e.toString())                       // placeholder
```

## Content strings

The server resolves the locale chain for top-level content (chapters,
parameters, assets) via the `*Localized` endpoints — see
[`PUBLIC_API.md`](./PUBLIC_API.md) and the User-role endpoints. The client
just sends the active `localeKey`; the server returns rendered content
plus a `resolvedLocaleKey` per item.

For **embedded** translations (`LocalizedQuizContent`, `LocalizedAiPrompt`)
the client uses `LocaleResolver`
(`lib/core/localization/locale_resolver.dart`):

```dart
final chain = LocaleResolver.resolveChain(
  requested: ref.watch(currentLocaleProvider),
  orgDefault: moduleConfig?.defaultLocaleKey,
);
final match = LocaleResolver.firstMatch<LocalizedQuizContent>(
  chain: chain,
  items: question.translations ?? [],
  keyOf: (t) => t.localeKey ?? t.languageCode,
);
```

Fallback chain order:

1. Requested locale.
2. Org default locale (`ModuleConfig.defaultLocaleKey`).
3. System default (`US-en`).

If nothing matches, the root field on the model is used (which is itself
populated from the default-locale `*Localization` row server-side).

## RTL support

### Auto-applied by Flutter

Flutter's `Localizations.localeOf(context)` drives the ambient
`Directionality`. For `ar` / `fa` / `he` / `ur`, Material widgets
automatically:

- Flip horizontal `Row` order (start = right, end = left).
- Mirror text alignment (`TextAlign.start` becomes right-aligned).
- Mirror the default `AppBar` leading icon (back button).
- Mirror navigation drawers, tooltips, dropdowns.

### What you must do

The framework only handles widgets that opt into Directionality. Your code
must use **logical** layout APIs instead of left/right ones:

| Don't use                          | Use instead                                |
|-----------------------------------|--------------------------------------------|
| `EdgeInsets.only(left: …)`         | `EdgeInsetsDirectional.only(start: …)`     |
| `EdgeInsets.only(right: …)`        | `EdgeInsetsDirectional.only(end: …)`       |
| `EdgeInsets.fromLTRB(…)`           | `EdgeInsetsDirectional.fromSTEB(…)`        |
| `Alignment.centerLeft`             | `AlignmentDirectional.centerStart`         |
| `Alignment.centerRight`            | `AlignmentDirectional.centerEnd`           |
| `Border(left: …)` / `Border(right: …)` | `BorderDirectional(start: …, end: …)`  |
| `Positioned(left: …, right: …)`    | `PositionedDirectional(start: …, end: …)`  |
| Direction-sensitive icons (`arrow_back_ios`, `chevron_right`, `arrow_forward`) | Set `textDirection: Directionality.of(context)` on the `Icon` so it mirrors |

`EdgeInsets.symmetric(...)`, `EdgeInsets.all(...)`, and
`EdgeInsets.only(top: …, bottom: …)` are RTL-safe and need no migration.

Hardcoded `Border(top: …)` / `Border(bottom: …)` are horizontal and
RTL-safe too.

### Icons that need explicit direction

Some Material icons are directionally asymmetric. Wrap them with the
ambient direction so they flip in Arabic:

```dart
Icon(
  Icons.chevron_right_rounded,
  textDirection: Directionality.of(context),
)
```

In the User shell, these are: `chevron_right_rounded`, `arrow_back_ios`,
`arrow_forward_rounded`, `arrow_back`. The `Material` AppBar back-button
already mirrors itself; we set `textDirection` explicitly for visual
consistency when these icons appear in custom layouts.

### Date / number formatting

Use the ambient locale for `DateFormat` so dates render in the right
calendar and language:

```dart
final locale = Localizations.localeOf(context).toLanguageTag();
final fmt = DateFormat.yMMMd(locale);
```

The `intl` package is already a dependency.

## Adding a new translation key

1. **Add the key to `lib/l10n/app_en.arb`** with placeholders and a
   `description`. Keep keys camelCase, prefix-grouped by feature
   (`modulesSummaryAssigned`, `quizFinishQuiz`, …).
2. **Mirror the key into every other ARB file** (`app_ar.arb`, `app_ta.arb`).
   For ICU plurals, use the right CLDR categories — Arabic needs
   `zero`/`one`/`two`/`few`/`many`/`other`, Tamil uses `=0`/`=1`/`other`.
3. Run `flutter gen-l10n` (or just run/hot-restart — Flutter regenerates
   on build).
4. Use the key:

   ```dart
   final t = AppLocalizations.of(context);
   Text(t.myNewKey)
   ```

### Conventions

- **No hardcoded user-visible English** in screens. If you can't find a
  matching key, add one.
- **No string interpolation for plural cases.** Use ICU plural ARB syntax
  with a typed placeholder.
- **Validation / error messages** raised from logic (e.g. `throw
  Exception('…')`) should resolve their text from `AppLocalizations`
  before throwing — see `AccountSettingsPage._showChangePasswordSheet`.

## Adding a new locale

### Step 1 — UI strings (ship in app binary)

1. Create `lib/l10n/app_<lang>.arb` with `"@@locale": "<lang>"` and
   translations for every key in `app_en.arb`. Missing keys fall back to
   the English template, but the linter will warn.
2. Run `flutter gen-l10n`. New `app_localizations_<lang>.dart` appears in
   `lib/l10n/generated/`.
3. If the language is **RTL** and not already in the
   `UiLocaleResolver._rtlLanguages` set, add its lowercase ISO code.

### Step 2 — Server-side catalog

The actual *enabled* locales for an org are stored on the server, not
ARB-driven. The admin must:

1. Add the `Region` row (or pick an existing one) via the Admin → Locales
   screen.
2. Add a `LocaleConfig` row with `regionCode`, `languageCode` (matching
   the new ARB), `localeKey`, and `displayName`.
3. (Optional) Set a per-row `fallbackLocaleKey`.

The new locale immediately appears in the Settings → Language & Region
drop-down on next `getMyLocales()` fetch — no client release required.

### Step 3 — Translate per-content rows (optional)

To localize theory / training / assessment / asset content into the new
locale, use the per-content **Localizations** dialog in the admin/manager
content editors. Until rows exist, the locale resolver chain falls back to
the org default.

## Testing

Tests live under `admin_panel_flutter/test/`.

- `core/localization/ui_locale_resolver_test.dart` — locale-key parsing,
  RTL detection, Locale conversion.
- `core/localization/locale_resolver_test.dart` — `resolveChain`
  dedup/ordering, `firstMatch` walk semantics.
- `l10n/app_localizations_widget_test.dart` — renders a probe widget in
  `en`, `ar`, `ta`, and an unsupported locale; verifies (a) translated
  strings appear, (b) `Directionality` is `rtl` for `ar` and `ltr`
  otherwise, (c) ICU plural forms resolve correctly.

Run:

```bash
cd admin_panel_flutter && flutter test
```

When you add a new ARB key, extend the probe widget in
`app_localizations_widget_test.dart` if it has interesting plural or
direction-sensitive behavior.

## Known limitations

- **Admin / OrgAdmin / Manager shells are not yet localized.** The pattern
  extends to them — add `AppLocalizations.of(context)` calls and migrate
  hardcoded EdgeInsets, but it hasn't been done yet.
- **Quiz answer indices are language-independent.**
  `LocalizedQuizContent` translates the question text and answer labels;
  the `correctAnswer: int` index on `QuizQuestion` is shared across all
  locales. Keep answers in the same order when translating.
- **Charts (`fl_chart`) don't auto-flip in RTL.** Axis labels stay where
  they are; we use logical padding around the container but the chart
  itself renders LTR. If RTL chart layout becomes important, look at
  `LineChartData.rotationQuarterTurns` or render axis titles externally.
- **`flutter_localizations` does not auto-fallback an unsupported locale
  to the template.** Flutter's `basicLocaleListResolution` picks the first
  matching `supportedLocale` — if the user's device locale isn't in our
  set, the resolution policy may pick `ar`, `en`, or `ta` depending on
  ordering. We work around this by always pinning `MaterialApp.locale` to
  a value derived from `currentLocaleProvider`, so the active locale is
  always one we support.
