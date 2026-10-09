# SECURITY-CHECKLIST.md

## Secrets and credentials

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 1 | No API key, token or password is hardcoded in `lib/`, including in comments and commented-out code | Yes | Checked every file in `lib/`. No backend has been wired up yet — all data (professors, reviews) is hardcoded sample data with no credentials of any kind. |
| 2 | Anything private is in a gitignored config or passed with `--dart-define`, with an example file committed | N/A | No config exists yet since no backend (Firebase) has been connected. Will apply once Firebase is set up, per the plan in Proposal v2 ("How my app saves data"). |
| 3 | No keystore, `key.properties` or signing credential is in the repository | N/A | No release/signed build has been created yet; app has only been run in debug mode so far. |
| 4 | Git history is clean: I searched `git log -p` for password, secret, api key and token | Yes | Ran `git log -p \| grep -i "api_key\|secret\|password\|token"`. The only matches were placeholder/example lines from course documentation and workflow template scaffolding (e.g. `EXAMPLE_API_KEY`, `put_your_key_here`, commented-out lines like `# GEMINI_API_KEY=put_your_key_here`), not real credentials. No actual key, password or token was found. |
| 5 | Any credential that was ever committed has been rotated | N/A | No credential has ever been committed, since none has existed yet. |

## GitHub Actions

No workflows exist in this repository yet, so every row below is marked N/A.

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 6 | No secret value is written literally in any workflow YAML file | N/A | No GitHub Actions workflow file exists in the repository yet. |
| 7 | Secrets are stored in repository Actions secrets and read with `${{ secrets.NAME }}` | N/A | No workflow exists yet to read secrets from. |
| 8 | No workflow step echoes, dumps or debug-prints a secret, and I opened a recent run's log to confirm | N/A | No workflow runs exist yet, since there is no workflow. |
| 9 | If I build a signed APK: the keystore is a base64 secret decoded to a file at build time, never printed | N/A | No signed APK build has been set up yet. |
| 10 | Uploaded build artifacts contain no key file, keystore or generated config | N/A | No build artifacts have been uploaded via Actions yet. |
| 11 | Third-party actions are pinned to a commit SHA, not a moveable tag | N/A | No workflow uses any third-party actions yet. |
| 12 | Secret scanning and push protection are enabled on the repository | N/A | Not yet checked/enabled, since the repository is still private and no secrets exist yet to protect. Will confirm this setting is turned on before making the repository public. |

## Backend and security rules

No backend is connected yet, so most rows below are marked N/A.

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 13 | Firestore and Storage rules are not left open to anyone; they require an authenticated user | N/A | No Firebase project or Firestore database has been created yet (see README "Known issues" — Firebase setup/spike has not been done yet). |
| 14 | Rules restrict a user to their own documents where that makes sense | N/A | Same as above — no rules exist yet since there's no backend. |
| 15 | If Supabase: Row Level Security is on for every table | N/A | Not using Supabase; Firebase was the chosen storage approach (see Proposal v2). |
| 16 | Firebase and Google API keys are restricted in the Google Cloud console to the APIs and app they are for | N/A | No Firebase project has been created yet, so no keys exist to restrict. |
| 17 | I opened the app signed out and confirmed I could not read or write data I should not | N/A | No login/auth system exists yet to test being "signed out" against. |
| 18 | Seed and sample data is invented, not real people's data | Yes | All current sample data (professor names like "Dr. Santos," "Prof. Reyes," "Dr. Cruz," and the sample student "Juan Dela Cruz") is invented for development. Confirmed none of it refers to a real person. |

## Input and app surface

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 19 | Input is validated before it is written, not only styled as valid in the UI | Yes | The Form Page's `_submit()` method checks that the professor name field is non-empty and that all three star ratings are non-zero before proceeding, and shows an error message if not. Nothing is actually written to storage yet since there's no backend, but the validation logic runs ahead of where a write would happen. |
| 20 | Nothing secret is recoverable from the built app, since a shipped binary can be unpacked | Yes | No secrets exist anywhere in the app's code yet, so there is nothing to recover from a built binary. |

## Repository and privacy

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 21 | No student number, personal email, phone number or home address in the repository or in commit messages | Yes | Reviewed the sample data and commit messages. The only email present is the fake sample `juan.delacruz@hau.edu.ph`, used for the Profile Page placeholder; confirmed nothing real is present. |
| 22 | No classmate's personal data in the repository | Yes | This is a solo project; no classmate data is involved anywhere in the repository. |
| 23 | Dependencies come from pub.dev, and `build/` and `.dart_tool/` are gitignored | Yes | All dependencies are Flutter's own SDK packages (no custom/third-party packages added yet). `.gitignore` was generated by `flutter create` and includes `build/` and `.dart_tool/` by default; confirmed both are listed. |
| 24 | Images, fonts and other assets are mine, licensed, or credited | Yes | No custom images, fonts, or other assets have been added yet — the app currently only uses Flutter's default Material icon set. |
| 25 | Repository visibility is deliberate, and I checked it after my last push | Yes | Checked GitHub repository Settings: the repository is currently set to **Private**. This is deliberate while the project is still in an early, unfinished state; visibility will be revisited before the finals deadline, when the repository needs to be public. |

## Anything I found and fixed

Running through this checklist didn't turn up anything that needed fixing — the project doesn't have a backend, workflows, or any assets yet, so most rows are honestly N/A rather than a real pass. The one thing worth noting is that I ran the `git log` secret search for the first time doing this checklist, rather than earlier, and confirmed the only matches were harmless course template placeholders. I now know to keep this repository **private** until Firebase is set up and secrets are handled properly (git-ignored `.env` locally, repository secrets for deploy), and to re-run this same checklist once the backend exists, since most of section "Backend and security rules" will actually apply at that point.
