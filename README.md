# FitGently Nutrition

A premium elderly-focused nutrition and wellness iOS app. Gentle, simple, and emotionally supportive.

## Features

- Daily nourishment score (not calorie counting)
- Meal photo logging with AI feedback
- Simple manual food logging (giant buttons, S/M/L portions)
- Hydration tracking with visual glass counter
- Gentle AI coaching insights
- Progress tracking with weekly trends
- Simple meal plans and easy recipes
- Family/caregiver mode
- Interactive onboarding

## Getting Started (Local Development)

### Requirements

- macOS 14+
- Xcode 16+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)

### Setup

```bash
# Install XcodeGen
brew install xcodegen

# Generate the Xcode project
xcodegen generate

# Open in Xcode
open FitGentlyNutrition.xcodeproj
```

## Building an IPA via GitHub Actions

Every push to `main` automatically builds two artifacts:

| Artifact | Description | Install method |
|---|---|---|
| `FitGentlyNutrition-unsigned-*.ipa` | Unsigned IPA | AltStore, Sideloadly |
| `FitGentlyNutrition-signed-*.ipa` | Ad-hoc signed IPA | Registered devices |

Download artifacts from the **Actions** tab → latest workflow run → **Artifacts** section.

### Creating a Release IPA

Push a version tag to trigger a GitHub Release with the IPA attached:

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Installing the IPA

**Option A — AltStore (no Apple Developer account needed):**
1. Install [AltStore](https://altstore.io) on your iPhone
2. Download the unsigned IPA from Actions artifacts
3. In AltStore tap **+** and select the IPA file
4. Re-sign every 7 days via AltStore

**Option B — Sideloadly (easiest, no developer account):**
1. Download [Sideloadly](https://sideloadly.io) on your Mac/PC
2. Connect iPhone via USB and trust the computer
3. Drag the IPA into Sideloadly, enter your Apple ID, click **Start**
4. On iPhone: Settings → General → VPN & Device Management → trust your Apple ID

**Option C — Ad-hoc signing (Apple Developer account required):**

Add these GitHub repository secrets (Settings → Secrets → Actions):

| Secret | Description |
|---|---|
| `CERTIFICATES_P12` | Base64-encoded P12 distribution certificate |
| `CERTIFICATES_P12_PASSWORD` | P12 certificate password |
| `PROVISIONING_PROFILE` | Base64-encoded `.mobileprovision` file |
| `KEYCHAIN_PASSWORD` | Any password (used to create a temporary keychain) |
| `DEVELOPMENT_TEAM` | Your 10-character Apple Team ID |

To base64-encode your certificate/profile on Mac:
```bash
base64 -i certificate.p12 | pbcopy      # paste as CERTIFICATES_P12 secret
base64 -i profile.mobileprovision | pbcopy  # paste as PROVISIONING_PROFILE secret
```

## Architecture

```
FitGentlyNutrition/
├── App/          — Entry point, AppState, ContentView
├── DesignSystem/ — Colors, typography, spacing, animations
├── Components/   — Reusable UI: FGCard, FGButton, FGProgressRing, etc.
├── Models/       — SwiftData models
├── Services/     — Business logic: scoring, insights, notifications, HealthKit
├── ViewModels/   — MVVM view models (Observation framework)
└── Views/        — All screens: Home, Meals, Progress, Plans, Settings, Onboarding
```

**Tech stack:** SwiftUI · SwiftData · iOS 17+ · MVVM · `@Observable`
