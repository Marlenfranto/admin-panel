# Public API Reference

This document describes every method on `PublicApiEndpoint`
(`admin_panel_server/lib/src/endpoints/public_api_endpoint.dart`) — the
unauthenticated surface used by the external training app, the AR Expert
client, and the certificate / progress callbacks.

> All methods except `login` validate an `apiKey` parameter against
> `session.passwords['serviceApiKey']` (see `admin_panel_server/config/passwords.yaml`).
> A request with a missing or wrong key throws `"Invalid API key."`.

> All content responses now embed the org's **region/locale catalog**
> (`defaultLocaleKey`, `regions`, `supportedLocales`). Localized variants
> additionally embed the **resolution envelope** (`requestedLocaleKey`,
> `resolvedLocaleChain`) and add `resolvedLocaleKey` on every content item
> so the client can show which locale actually rendered.
>
> Every locale-key field is now paired with a sibling **language code**
> field carrying the bare ISO-639 code (e.g. `IN-en` → `en`). The siblings
> are:
> - `defaultLocaleKey` → `defaultLanguageCode`
> - `requestedLocaleKey` → `requestedLanguageCode`
> - `resolvedLocaleChain` → `resolvedLanguageChain` (parallel list)
> - `resolvedLocaleKey` (per item) → `resolvedLanguageCode` (per item)
> - The envelope-root `localeKey` legacy alias on `getTheorySectionLocalized`
>   → `languageCode`
>
> Inside embedded locale rows (`chapterDetails[]`, `translations[]`, every
> `LocaleConfig` entry in `supportedLocales`) the `languageCode` field is
> already part of the row shape and is emitted alongside `localeKey`.

---

## Table of Contents

1. [Conventions](#conventions)
2. [Regional locale model](#regional-locale-model)
3. [Endpoints](#endpoints)
   - [`login`](#login)
   - [`getContentBundle`](#getcontentbundle)
   - [`getTheorySection`](#gettheorysection)
   - [`getTheorySectionLocalized`](#gettheorysectionlocalized)
   - [`getTrainingParameters`](#gettrainingparameters)
   - [`getTrainingParametersLocalized`](#gettrainingparameterslocalized)
   - [`getAssessmentParameters`](#getassessmentparameters)
   - [`getAssessmentParametersLocalized`](#getassessmentparameterslocalized)
   - [`getAssets`](#getassets)
   - [`getAssetsLocalized`](#getassetslocalized)
   - [`getModuleConfig`](#getmoduleconfig)
   - [`getLocales`](#getlocales)
   - [`getRegions`](#getregions)
   - [`getLanguages`](#getlanguages-deprecated) (deprecated)
   - [`updateModuleStatus`](#updatemodulestatus)
   - [`submitTrainingCertificate`](#submittrainingcertificate)
4. [Shared response shapes](#shared-response-shapes)
5. [Error responses](#error-responses)

---

## Conventions

- **Transport**: Serverpod endpoint methods are addressable as HTTP `POST`
  requests at `POST /publicApi/<methodName>` with a JSON body whose keys are
  the method parameter names. Dev base URL: `http://localhost:8080/`.
- **Auth**: Pass `apiKey` in the JSON body. `login` does not take `apiKey`;
  it authenticates with email + password and returns the bearer credentials
  (`keyId`, `key`) used for any future authenticated calls into the
  Serverpod auth module.
- **Identifiers**:
  - `organizationId`: `int` — the Serverpod org row id.
  - `userId`: `String` (parsed as `int` server-side; non-numeric or
    not-found resolves to a null `AppUser`, which is allowed for the
    certificate POST and rejected for module-status writes).
- **Date/time**: dates are returned as `YYYY-MM-DD` strings (UTC) where
  noted. Timestamps inside model JSON are ISO-8601 UTC.
- **`__className__`**: Every Serverpod model serializes with a
  `__className__` discriminator. The Public API strips this recursively
  from all responses (see `_clean` / `_cleanValue`).

## Regional locale model

A **locale key** has the canonical form `REGION-language` —
`^[A-Z]{2}-[a-z]{2,3}$`. Examples: `US-en`, `UK-en`, `AE-ar`.

Each organization owns three independent catalogs:

| Catalog        | Table          | Purpose                                                   |
|----------------|----------------|-----------------------------------------------------------|
| `Region`       | `region`       | Per-org pool of region codes (`US`, `UK`, `AE`, …).       |
| `LocaleConfig` | `locale_config`| Per-org locales (`regionCode` + `languageCode` + key).    |
| `ModuleConfig` | `module_config`| Holds `defaultLocaleKey` (defaults to `US-en`).           |

**Locale fallback chain** (computed by `LocaleResolver.resolveChain`):

1. The requested locale key.
2. The matching `LocaleConfig.fallbackLocaleKey`, if set.
3. The organization's `ModuleConfig.defaultLocaleKey`.
4. The system default `US-en`.

Localized read endpoints walk this chain per item and return the first
non-null `*Localization` row hit. Each item carries a `resolvedLocaleKey`
field telling the client which step in the chain matched (or `null` if no
localization existed and the legacy root field was returned).

---

## Endpoints

### `login`

Authenticate a user and bootstrap the client with `userInfo`, the user's
`Organization`, and a fully-resolved `ModuleConfigPublic`.

| Field | Type | Notes |
|------|------|------|
| `email` | `String` | The user's email address. |
| `password` | `String` | Plaintext (over TLS). |

**Request**

```json
POST /publicApi/login
{
  "email": "admin@mako.com",
  "password": "Mako@123"
}
```

**Response — success**

```json
{
  "success": true,
  "userInfo": {
    "id": 1,
    "userIdentifier": "admin@mako.com",
    "userName": null,
    "fullName": "Mako Admin",
    "email": "admin@mako.com",
    "created": "2025-01-04T10:11:12.000Z",
    "imageUrl": null,
    "scopeNames": ["admin"],
    "blocked": false
  },
  "organization": {
    "id": 1,
    "name": "Mako Industrial",
    "imageUrl": null,
    "contentVersion": 12,
    "managerId": null,
    "parentId": null
  },
  "moduleConfig": {
    "configId": "ORG1_v1.0.0",
    "lastUpdated": "2026-05-29",
    "contentVersion": 12,
    "subscriptionModules": {
      "theoryModule": true,
      "aiExpertModule": true,
      "smartTrainingModule": true,
      "assessmentModule": false
    },
    "defaultLocaleKey": "US-en",
    "defaultLanguageCode": "en",
    "supportedLocales": [
      {
        "id": 7,
        "organizationId": 1,
        "regionCode": "US",
        "languageCode": "en",
        "localeKey": "US-en",
        "displayName": "English (US)",
        "enabled": true,
        "isDefault": true,
        "fallbackLocaleKey": null
      },
      {
        "id": 8,
        "organizationId": 1,
        "regionCode": "AE",
        "languageCode": "ar",
        "localeKey": "AE-ar",
        "displayName": "Arabic (UAE)",
        "enabled": true,
        "isDefault": false,
        "fallbackLocaleKey": "US-en"
      }
    ],
    "passingPercentage": 60,
    "aiChatPrompt": "You are an AR fire-safety expert…",
    "aiChatPromptTranslations": [
      {
        "languageCode": "ar",
        "localeKey": "AE-ar",
        "prompt": "أنت خبير في السلامة من الحرائق…"
      }
    ]
  },
  "keyId": 42,
  "key": "eyJhbGciOi…"
}
```

`aiChatPrompt` is **already resolved** to the user's `preferredLocaleKey`
through the fallback chain. The unresolved root prompt and the full
translation list are also returned (`aiChatPromptTranslations`) so a
client can switch locales without a re-fetch.

**Response — failure**

```json
{ "success": false }
```

---

### `getContentBundle`

Bulk fetch of theory chapters + training params + assessment params for a
single round trip on app launch.

**Request**

```json
POST /publicApi/getContentBundle
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "IN-en",
  "defaultLanguageCode": "en",
  "regions": [
    { "id": 1, "organizationId": 1, "code": "IN", "displayName": "India", "enabled": true }
  ],
  "supportedLocales": [
    { "id": 1, "organizationId": 1, "regionCode": "IN", "languageCode": "en", "localeKey": "IN-en", "displayName": "India (English)", "enabled": true, "isDefault": true, "fallbackLocaleKey": null },
    { "id": 2, "organizationId": 1, "regionCode": "IN", "languageCode": "ta", "localeKey": "IN-ta", "displayName": "India (Tamil)", "enabled": true, "isDefault": false, "fallbackLocaleKey": "IN-en" }
  ],
  "organizationId": 1,
  "contentVersion": 137,
  "theorySection": {
    "moduleTitle": "Mako",
    "chapters": [
      {
        "id": 2,
        "organizationId": 1,
        "chapterOrder": 1,
        "chapterDetails": [
          {
            "id": 1,
            "chapterId": 2,
            "localeKey": "IN-en",
            "title": "Fire",
            "thumbnailUrl": "https://cdn.example/chapter-1.png",
            "videoUrl": "https://cdn.example/chapter-1.mp4",
            "languageCode": "en"
          },
          {
            "id": 7,
            "chapterId": 2,
            "localeKey": "IN-ta",
            "title": "நெருப்பு",
            "thumbnailUrl": "https://cdn.example/chapter-1.png",
            "videoUrl": "https://cdn.example/chapter-1.mp4",
            "languageCode": "ta"
          }
        ],
        "questions": [
          {
            "question": "Which of these is an uncontrolled fire?",
            "answers": ["Cooking fire", "Lighting fire", "Forest fire", "Candle fire"],
            "correctAnswer": 2,
            "languageCode": "en",
            "theoryTranslations": [
              {
                "languageCode": "ta",
                "question": "கீழ்க்கண்டவற்றில் எது கட்டுப்பாடின்றி இயற்கைக்கு பெரிய சேதத்தை ஏற்படுத்தும் தீ?",
                "answers": ["சமையல் தீ", "ஒளி தீ", "காட்டு தீ", "மெழுகுவர்த்தி தீ"]
              }
            ]
          }
        ]
      }
    ]
  },
  "trainingParameters": [
    {
      "id": 2,
      "organizationId": 1,
      "paramId": "safe_distance",
      "maxScore": 5,
      "scoringRules": [
        { "threshold": 80, "score": 5, "feedback": "Superior safety awareness." },
        { "threshold": 60, "score": 3, "feedback": "Caution required." },
        { "threshold": 0,  "score": 0, "feedback": "Safety violation." }
      ],
      "name": "SafeDistance",
      "description": "",
      "languageCode": "en",
      "translations": [
        {
          "id": 4,
          "parameterId": 2,
          "localeKey": "IN-ta",
          "name": "பாதுகாப்பான தூரம்",
          "description": "",
          "scoringFeedbacks": [
            "உயர்ந்த பாதுகாப்பு விழிப்புணர்வு.",
            "கவனம் தேவை.",
            "பாதுகாப்பு மீறல்."
          ],
          "languageCode": "ta"
        }
      ]
    }
  ],
  "assessmentParameters": [ /* same shape as trainingParameters */ ]
}
```

Shape notes:

- **`theorySection.chapters[].chapterDetails`** — one entry per
  `TheoryChapterLocalization` row for the chapter, including the
  default-locale row. Each entry carries `localeKey` plus a derived
  `languageCode` (so `IN-ta` adds `"languageCode": "ta"`). The chapter
  object itself does NOT carry top-level `title` / `thumbnailUrl` /
  `videoUrl` — all per-language content lives inside `chapterDetails`.
- **`theorySection.chapters[].questions[]`** — the top-level `question` /
  `answers` / `correctAnswer` are the **default-locale** content, tagged
  with `languageCode` set to the default language. `theoryTranslations`
  contains only the **non-default-language** variants (the default is
  already at the top), each emitted as
  `{languageCode, question, answers}`.
- **`trainingParameters[]` / `assessmentParameters[]`** — top-level
  `name` / `description` / `scoringRules` are the default-locale content,
  with `languageCode` set to the default language. `translations`
  contains only the **non-default-locale** rows, each tagged with its
  `languageCode`.

To render in a non-default locale on demand, call the `*Localized`
variants below (they walk the fallback chain per item).

---

### `getTheorySection`

Default-locale theory chapters with the region/locale catalog.

**Request**

```json
POST /publicApi/getTheorySection
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* Region[] */ ],
  "supportedLocales": [ /* LocaleConfig[] */ ],
  "organizationId": 1,
  "moduleTitle": "Mako Industrial",
  "chapters": [
    {
      "id": 12,
      "organizationId": 1,
      "chapterOrder": 1,
      "questions": [
        {
          "question": "What is the first step?",
          "answers": ["Sound the alarm", "Run", "Hide", "Wait"],
          "correctAnswer": 0,
          "translations": [
            {
              "languageCode": "ar",
              "localeKey": "AE-ar",
              "question": "ما هي الخطوة الأولى؟",
              "answers": ["دق الإنذار", "اهرب", "اختبئ", "انتظر"]
            }
          ]
        }
      ],
      "title": "Fire Basics",
      "description": "Intro to fire-safety fundamentals.",
      "thumbnailUrl": "https://cdn.example/thumb-12.jpg",
      "videoUrl": "https://cdn.example/video-12.mp4",
      "videoMetadata": { "durationMs": 184000, "width": 1920, "height": 1080 }
    }
  ]
}
```

`title`, `description`, `thumbnailUrl`, `videoUrl`, `videoMetadata` are
non-persistent fields hydrated from the **default-locale**
`TheoryChapterLocalization` row. The embedded
`questions[].translations` list is the source of truth for quiz text in
non-default locales.

---

### `getTheorySectionLocalized`

Locale-resolved theory chapters. Walks the fallback chain per chapter.

**Request**

```json
POST /publicApi/getTheorySectionLocalized
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "localeKey": "AE-ar"
}
```

`localeKey` must match `^[A-Z]{2}-[a-z]{2,3}$` or the call throws
`"Invalid locale key \"...\". Expected REGION-language ..."`.

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "requestedLocaleKey": "AE-ar",
  "requestedLanguageCode": "ar",
  "resolvedLocaleChain": ["AE-ar", "US-en"],
  "resolvedLanguageChain": ["ar", "en"],
  "organizationId": 1,
  "moduleTitle": "Mako Industrial",
  "localeKey": "AE-ar",
  "languageCode": "ar",
  "chapters": [
    {
      "id": 12,
      "organizationId": 1,
      "chapterOrder": 1,
      "questions": [ /* same shape as above */ ],
      "title": "أساسيات الحريق",
      "description": null,
      "thumbnailUrl": "https://cdn.example/thumb-12-ar.jpg",
      "videoUrl": "https://cdn.example/video-12-ar.mp4",
      "videoMetadata": { "durationMs": 184000, "width": 1920, "height": 1080 },
      "resolvedLocaleKey": "AE-ar",
      "resolvedLanguageCode": "ar"
    },
    {
      "id": 13,
      "organizationId": 1,
      "chapterOrder": 2,
      "questions": [],
      "title": "Evacuation Plans",
      "description": null,
      "thumbnailUrl": "https://cdn.example/thumb-13.jpg",
      "videoUrl": null,
      "videoMetadata": null,
      "resolvedLocaleKey": "US-en",
      "resolvedLanguageCode": "en"
    }
  ]
}
```

`resolvedLocaleKey` per chapter tells you which step in
`resolvedLocaleChain` matched. `null` means no `*Localization` row existed
for any chain key and the response reflects the legacy hydrated content
(default-locale baseline).

`localeKey` at the envelope root is a legacy alias for `requestedLocaleKey`
kept for pre-envelope callers.

---

### `getTrainingParameters`

Default-locale training parameters. **Return shape changed**: this method
now returns an envelope (`{…, parameters: [...]}`) rather than a bare list.

**Request**

```json
POST /publicApi/getTrainingParameters
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "organizationId": 1,
  "parameters": [
    {
      "id": 22,
      "organizationId": 1,
      "paramId": "extinguisher_grip",
      "maxScore": 10,
      "scoringRules": [ { "key": "grip", "weight": 1 } ],
      "name": "Extinguisher grip",
      "description": "How firmly the user holds the extinguisher.",
      "translations": null
    }
  ]
}
```

---

### `getTrainingParametersLocalized`

Locale-resolved training parameters. Each parameter carries an extra
`scoringFeedbacks` list pulled from `TrainingParameterLocalization`.

**Request**

```json
POST /publicApi/getTrainingParametersLocalized
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "localeKey": "AE-ar"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "requestedLocaleKey": "AE-ar",
  "requestedLanguageCode": "ar",
  "resolvedLocaleChain": ["AE-ar", "US-en"],
  "resolvedLanguageChain": ["ar", "en"],
  "organizationId": 1,
  "parameters": [
    {
      "id": 22,
      "organizationId": 1,
      "paramId": "extinguisher_grip",
      "maxScore": 10,
      "scoringRules": [ { "key": "grip", "weight": 1 } ],
      "name": "إمساك الطفاية",
      "description": "كيف يمسك المستخدم بطفاية الحريق.",
      "translations": null,
      "scoringFeedbacks": [
        "تحتاج إلى إمساك أقوى",
        "إمساك جيد",
        "ممتاز"
      ],
      "resolvedLocaleKey": "AE-ar",
      "resolvedLanguageCode": "ar"
    }
  ]
}
```

---

### `getAssessmentParameters`

Default-locale assessment parameters. Same envelope as
`getTrainingParameters`.

**Request**

```json
POST /publicApi/getAssessmentParameters
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "organizationId": 1,
  "parameters": [
    {
      "id": 31,
      "organizationId": 1,
      "paramId": "evacuation_time",
      "maxScore": 100,
      "scoringRules": [ { "key": "seconds", "weight": -1 } ],
      "name": "Evacuation time",
      "description": "Wall-clock seconds to exit the room.",
      "translations": null
    }
  ]
}
```

---

### `getAssessmentParametersLocalized`

Locale-resolved assessment parameters.

**Request**

```json
POST /publicApi/getAssessmentParametersLocalized
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "localeKey": "AE-ar"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "requestedLocaleKey": "AE-ar",
  "requestedLanguageCode": "ar",
  "resolvedLocaleChain": ["AE-ar", "US-en"],
  "resolvedLanguageChain": ["ar", "en"],
  "organizationId": 1,
  "parameters": [
    {
      "id": 31,
      "organizationId": 1,
      "paramId": "evacuation_time",
      "maxScore": 100,
      "scoringRules": [ { "key": "seconds", "weight": -1 } ],
      "name": "وقت الإخلاء",
      "description": "الثواني المستغرقة للخروج من الغرفة.",
      "translations": null,
      "scoringFeedbacks": ["بطيء", "جيد", "ممتاز"],
      "resolvedLocaleKey": "AE-ar",
      "resolvedLanguageCode": "ar"
    }
  ]
}
```

---

### `getAssets`

Default-locale assets. **Return shape changed** — wraps the list in an
envelope.

**Request**

```json
POST /publicApi/getAssets
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "organizationId": 1,
  "assets": [
    {
      "id": 51,
      "organizationId": 1,
      "version": "1.4.0",
      "module": "smartTraining",
      "name": "Fire Extinguisher 3D",
      "description": "Generic ABC extinguisher model.",
      "url": "https://cdn.example/assets/extinguisher_v1.4.0.glb"
    }
  ]
}
```

---

### `getAssetsLocalized`

Locale-resolved assets.

**Request**

```json
POST /publicApi/getAssetsLocalized
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "localeKey": "AE-ar"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* … */ ],
  "supportedLocales": [ /* … */ ],
  "requestedLocaleKey": "AE-ar",
  "requestedLanguageCode": "ar",
  "resolvedLocaleChain": ["AE-ar", "US-en"],
  "resolvedLanguageChain": ["ar", "en"],
  "organizationId": 1,
  "assets": [
    {
      "id": 51,
      "organizationId": 1,
      "version": "1.4.0",
      "module": "smartTraining",
      "name": "طفاية الحريق ثلاثية الأبعاد",
      "description": "نموذج طفاية ABC العام.",
      "url": "https://cdn.example/assets/extinguisher_v1.4.0_ar.glb",
      "resolvedLocaleKey": "AE-ar",
      "resolvedLanguageCode": "ar"
    }
  ]
}
```

---

### `getModuleConfig`

Returns the resolved public module config for one user. The AI chat prompt
is already resolved to the user's `preferredLocaleKey` through the
fallback chain.

**Request**

```json
POST /publicApi/getModuleConfig
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "userId": "42"
}
```

`userId` is a `String` (parsed as `int` server-side). A non-numeric or
not-found value is allowed — the response will omit `userId`,
`preferredLocaleKey`, and `moduleStatuses`, and the AI prompt will fall
back to the root prompt.

**Response**

```json
{
  "configId": "ORG1_v1.0.0",
  "lastUpdated": "2026-05-29",
  "contentVersion": 12,
  "subscriptionModules": {
    "theoryModule": true,
    "aiExpertModule": true,
    "smartTrainingModule": true,
    "assessmentModule": false
  },
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "supportedLocales": [ /* LocaleConfig[] */ ],
  "passingPercentage": 60,
  "aiChatPrompt": "أنت خبير في السلامة من الحرائق…",
  "aiChatPromptTranslations": [
    { "languageCode": "en", "localeKey": "US-en", "prompt": "You are an AR fire-safety expert…" },
    { "languageCode": "ar", "localeKey": "AE-ar", "prompt": "أنت خبير في السلامة من الحرائق…" }
  ],
  "regions": [ /* Region[] */ ],
  "userId": 42,
  "preferredLocaleKey": "AE-ar",
  "moduleStatuses": {
    "theory": "completed",
    "aiExpert": "notStarted",
    "smartTraining": "inProgress",
    "assessment": "notStarted"
  }
}
```

`moduleStatuses` keys are the four `moduleId` constants
(`theory`, `aiExpert`, `smartTraining`, `assessment`). Values are the
`ModuleProgressStatus` enum names: `notStarted`, `inProgress`, `completed`.

`subscriptionModules` reflects the **per-user effective** enable state
(`UserModuleProgress.isEnabled` if a row exists, otherwise the
`ModuleConfig.<module>Module` org-level flag).

---

### `getLocales`

Lists the enabled `LocaleConfig` rows for an organization, wrapped in the
same region/locale envelope as the content endpoints. `locales` is an
alias for `supportedLocales` for convenience.

**Request**

```json
POST /publicApi/getLocales
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* Region[] */ ],
  "supportedLocales": [
    {
      "id": 7,
      "organizationId": 1,
      "regionCode": "US",
      "languageCode": "en",
      "localeKey": "US-en",
      "displayName": "English (US)",
      "enabled": true,
      "isDefault": true,
      "fallbackLocaleKey": null
    }
  ],
  "organizationId": 1,
  "locales": [ /* same as supportedLocales */ ]
}
```

---

### `getRegions`

Lists the enabled `Region` rows for an organization. The response shape is
identical to `getLocales` minus the `locales` alias, so a client can wire
the same envelope handler to both.

**Request**

```json
POST /publicApi/getRegions
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "organizationId": 1,
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [
    { "id": 3, "organizationId": 1, "code": "US", "displayName": "United States", "enabled": true },
    { "id": 4, "organizationId": 1, "code": "AE", "displayName": "United Arab Emirates", "enabled": true }
  ],
  "supportedLocales": [ /* LocaleConfig[] */ ]
}
```

---

### `getLanguages` (deprecated)

> **DEPRECATED.** Kept for the external training app that has not yet
> migrated to the regional locale model. New integrations should call
> [`getLocales`](#getlocales) and [`getRegions`](#getregions).

**Request**

```json
POST /publicApi/getLanguages
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>"
}
```

**Response**

```json
{
  "deprecated": true,
  "migrateTo": ["getLocales", "getRegions"],

  "defaultLanguage": "en",
  "supported": [
    { "code": "en", "name": "English (US)", "contentUrl": null },
    { "code": "ar", "name": "Arabic (UAE)", "contentUrl": null }
  ],

  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "regions": [ /* Region[] */ ],
  "supportedLocales": [ /* LocaleConfig[] */ ]
}
```

The legacy `defaultLanguage` / `supported` fields are kept verbatim; the
forward-compat `defaultLocaleKey` / `regions` / `supportedLocales` fields
are added on every response so a client can adopt the regional model
without changing endpoints first.

---

### `updateModuleStatus`

Updates `UserModuleProgress` for one user × module. The first transition
into `inProgress` records `startedAt`; the first transition into
`completed` records `completedAt`. Both timestamps are idempotent (never
overwritten once set).

**Request**

```json
POST /publicApi/updateModuleStatus
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "userId": "42",
  "moduleId": "smartTraining",
  "status": "inProgress"
}
```

| Field | Type | Notes |
|------|------|------|
| `userId` | `String` | Parsed as `int`. Throws `"User not found."` on miss. |
| `moduleId` | `String` | One of `theory`, `aiExpert`, `smartTraining`, `assessment`. |
| `status` | `ModuleProgressStatus` | Serialized by name: `notStarted`, `inProgress`, `completed`. |

**Response**

```json
true
```

Throws on unknown organization or user.

---

### `submitTrainingCertificate`

Records a completed `TrainingSessionResult` from the external training
app. `userId` is stored verbatim as `externalUserId`; if it parses as a
known `AppUser` id, the matching row is also linked via `appUserId`.

**Request**

```json
POST /publicApi/submitTrainingCertificate
{
  "organizationId": 1,
  "apiKey": "<serviceApiKey>",
  "userId": "42",
  "overallPercentage": 87,
  "criteriaValidation": [
    { "parameter": "extinguisher_grip", "score": 9 },
    { "parameter": "stance", "score": 8 }
  ]
}
```

**Response**

```json
{
  "success": true,
  "resultId": 119,
  "message": "Training result recorded successfully."
}
```

Throws `"Organization not found."` if `organizationId` is unknown.

---

## Shared response shapes

### `Region`

```json
{
  "id": 3,
  "organizationId": 1,
  "code": "US",
  "displayName": "United States",
  "enabled": true
}
```

### `LocaleConfig`

```json
{
  "id": 7,
  "organizationId": 1,
  "regionCode": "US",
  "languageCode": "en",
  "localeKey": "US-en",
  "displayName": "English (US)",
  "enabled": true,
  "isDefault": true,
  "fallbackLocaleKey": null
}
```

### `TheoryChapter` (default-locale, hydrated)

```json
{
  "id": 12,
  "organizationId": 1,
  "chapterOrder": 1,
  "questions": [
    {
      "question": "What is the first step?",
      "answers": ["…", "…", "…", "…"],
      "correctAnswer": 0,
      "translations": [
        {
          "languageCode": "ar",
          "localeKey": "AE-ar",
          "question": "…",
          "answers": ["…", "…", "…", "…"]
        }
      ]
    }
  ],
  "title": "Fire Basics",
  "description": "…",
  "thumbnailUrl": "…",
  "videoUrl": "…",
  "videoMetadata": { "durationMs": 184000, "width": 1920, "height": 1080 }
}
```

The localized variant adds:

```json
{ "resolvedLocaleKey": "AE-ar", "resolvedLanguageCode": "ar" }
```

### `TrainingParameter` / `AssessmentParameter` (default-locale, hydrated)

```json
{
  "id": 22,
  "organizationId": 1,
  "paramId": "extinguisher_grip",
  "maxScore": 10,
  "scoringRules": [ { "key": "grip", "weight": 1 } ],
  "name": "Extinguisher grip",
  "description": "…",
  "translations": null
}
```

The localized variants add:

```json
{
  "scoringFeedbacks": ["…", "…", "…"],
  "resolvedLocaleKey": "AE-ar",
  "resolvedLanguageCode": "ar"
}
```

### `Asset` (default-locale, hydrated)

```json
{
  "id": 51,
  "organizationId": 1,
  "version": "1.4.0",
  "module": "smartTraining",
  "name": "Fire Extinguisher 3D",
  "description": "…",
  "url": "…"
}
```

Localized variant adds `resolvedLocaleKey`.

### `ModuleConfigPublic`

```json
{
  "configId": "ORG1_v1.0.0",
  "lastUpdated": "2026-05-29",
  "contentVersion": 12,
  "subscriptionModules": {
    "theoryModule": true,
    "aiExpertModule": true,
    "smartTrainingModule": true,
    "assessmentModule": false
  },
  "defaultLocaleKey": "US-en",
  "defaultLanguageCode": "en",
  "supportedLocales": [ /* LocaleConfig[] */ ],
  "passingPercentage": 60,
  "aiChatPrompt": "…",
  "aiChatPromptTranslations": [
    { "languageCode": "ar", "localeKey": "AE-ar", "prompt": "…" }
  ]
}
```

### `TrainingCriteriaScore`

```json
{ "parameter": "extinguisher_grip", "score": 9 }
```

### `ModuleProgressStatus` (enum, serialized by name)

`"notStarted"`, `"inProgress"`, `"completed"`.

---

## Error responses

Methods throw a Dart `Exception`. Serverpod's HTTP layer serializes thrown
exceptions as a 4xx/5xx with a JSON error body containing the message.
Common messages:

| Trigger                                                          | Message                                                                                 |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| Missing / wrong `apiKey`                                         | `Invalid API key.`                                                                      |
| Unknown `organizationId`                                         | `Organization not found.`                                                               |
| Unknown `userId` (writes only)                                   | `User not found.`                                                                       |
| `getModuleConfig` / `getLanguages` with no `ModuleConfig` row    | `Module configuration not found for this organization.`                                 |
| `*Localized` call with malformed `localeKey`                     | `Invalid locale key "<key>". Expected REGION-language (e.g., US-en, UK-en, AE-ar).`     |
