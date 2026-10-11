# AI Usage

This project was built with AI assistance. I used Claude (Anthropic) for early Flutter drafts and OpenAI Codex for later implementation and fixes. I used ChatGPT occasionally to study concepts. I reviewed and changed AI suggestions as the app developed. Claude could not run Flutter in its environment, so its code was not compiled before I received it.

## 1. How I used AI

### 2026-09-23 - Course Page initial build

- **Tool:** Claude (Anthropic)
- **What I asked for:** Code a simple Flutter Course Page using the palette, type scale, spacing, and components in my Design System v2.
- **What it gave back:** A first-pass theme, Professor model, search bar, professor card, tag badge, bottom navigation, and Course Page with sample data.
- **What I kept, changed, and why:** I used the page and components as a rough starting point. I changed the visual layout, color placement, and professor cards to better match my design. I also wrote and revised the shared theme and navigation code; the initial draft is not evidence that I personally wrote every line in those files.
- **Commit:** [Course Page Rough Draft](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/6895fb4fc40eece33e3d6f3c31fd25cde5e479ef)

### 2026-09-28 - Profile and review form draft

- **Tool:** Claude (Anthropic)
- **What I asked for:** Draft a Profile Page and Review Form using the existing app style.
- **What it gave back:** Draft profile and form screens, a Review model, input and secondary button widgets, review card, and star-rating input.
- **What I kept, changed, and why:** I kept the screens and reusable widgets as a starting point and adjusted page layouts and color placement to fit the app. This commit is dated September 28; the date here follows the commit rather than the September 30 date in my earlier notes.
- **Commit:** [Form Page and Profile Page Draft](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/14c57a1e9548b6a69509b8888724771631d817bd)

### 2026-10-05 - Five-screen app and shared navigation

- **Tool:** Claude (Anthropic)
- **What I asked for:** Build out the five-screen app from my mockups and button specifications, including routes and the shared bottom navigation.
- **What it gave back:** Login, Courses, Reviews, Profile, and Form screens; sample professor and review data; supporting placeholder screens; and a shared top bar and bottom navigation.
- **What I kept, changed, and why:** I kept the five-screen structure and much of the visual design. I replaced the incorrect logo asset reference after adding my logo, adjusted text and button placement, and revised navigation behavior as I found routing problems. The top bar and bottom navigation were subsequently updated in the October 9 commit.
- **Commit:** [All Screens](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/b181c74723edec9d8444fc76626b76751b121696)

### 2026-10-09 - Navigation destinations and active icons

- **Tool:** OpenAI Codex
- **What I asked for:** Fix the bottom navigation so Home opens Courses, the school/cap icon opens Reviews, selected icons turn red, and the floating plus button opens only the Form page.
- **What it gave back:** Updates to the shared navigation and screen callbacks, including destination handling and active icon styling.
- **What I kept, changed, and why:** I kept the explicit destination mapping and adjusted navigation code across the screens so the selected destination is consistent. The plus button is wired to the Form route.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

### 2026-10-09 - Search for courses and professors

- **Tool:** OpenAI Codex
- **What I asked for:** Make the top-bar search usable to find courses or professors, and make the professor search in the review form return professor choices.
- **What it gave back:** Search UI and filtering/selection behavior for the shared top bar and the form's professor picker, with selections routed to the corresponding screen.
- **What I kept, changed, and why:** I kept the search interaction and result selection flow so a course selection returns to Courses and a professor selection opens Reviews. The app's available records are still sample data, so search is limited to those records.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

### 2026-10-09 - Review details on professor cards

- **Tool:** OpenAI Codex
- **What I asked for:** Show a recent review on each professor card, include the student and the stars they gave in the form, make category ratings visible on the card, and improve the card's spacing and appearance.
- **What it gave back:** Changes to the professor card and sample review data to show a recent review, reviewer, individual ratings, and more compact card content.
- **What I kept, changed, and why:** I kept the information hierarchy and adjusted the card design to make the ratings and review details easier to scan. These values are sample content and are not submitted or stored as real student reviews.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

### 2026-10-09 - Phone preview and narrow-screen layout

- **Tool:** OpenAI Codex
- **What I asked for:** Enable the phone-frame preview when running in Chrome and fix the top-bar overflow visible on the Reviews and Profile pages; adjust the bottom navigation's vertical placement in the phone frame.
- **What it gave back:** Device Preview setup and responsive top-bar/navigation layout changes.
- **What I kept, changed, and why:** I kept the phone preview and flexible sizing/position adjustments so the logo, search action, and navigation fit the preview. Device Preview is a development preview; it does not change the app's production screen dimensions.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

## 2. Where the AI got it wrong

### Case 1 - Course Page did not match my design

- **What it gave me:** An initial Course Page and professor card using the design system's colors and spacing.
- **What was wrong with it:** When I ran the app, the background, color placement, and widget positions did not match my intended design. The professor cards also looked too empty and blended into the page.
- **What I did instead:** I changed the layout and color placement, improved the contrast and density of the professor cards, and added visible rating and recent-review details. I reviewed and identified the specific portions I changed before treating any of this code as my own work.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

### Case 2 - Navigation did not follow the intended destinations

- **What it gave me:** Bottom-navigation code where some icons led to the wrong page; the Home and school icons also did not consistently show the selected red state, and the middle plus action could lead to the wrong destination.
- **What was wrong with it:** The destinations were not consistent across screens. Home needs to open Courses, the school/cap icon needs to open Reviews, and the floating plus action needs to open the Form page only.
- **What I did instead:** I revised the shared navigation callbacks and destination handling across the screens, set the active icon color based on the current destination, and wired the plus button to the Form route.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

### Case 3 - Top bar logo overflowed in the phone preview

- **What it gave me:** A shared top bar with the app logo and search action sized for a wider layout.
- **What was wrong with it:** In the phone-frame preview, the logo and search button did not fit cleanly on the Reviews and Profile pages; part of the header overflowed.
- **What I did instead:** I changed the logo area to use flexible sizing and adjusted the top-bar layout so the search action remains visible at narrow widths.
- **Commit:** [Finished the screens and other documents](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)

## 3. Who wrote what

The entries below identify the parts I wrote or revised. For the Course Page and professor card, I am not claiming the whole files as mine; I need to identify and explain my specific changes before counting those lines toward my own share of the project.

### Written by me

#### Case 1 - Theme

- **File:** `lib/theme.dart`
- **Commit:** [Course Page Rough Draft](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/6895fb4fc40eece33e3d6f3c31fd25cde5e479ef)
- **What I wrote and why:** In `theme.dart`, I set the colors, text styles, and spacing so the app would follow the visual style I wanted.

#### Case 2 - Shared top bar

- **File:** `lib/widgets/app_top_bar.dart`
- **Commit:** [All Screens](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/b181c74723edec9d8444fc76626b76751b121696)
- **What I wrote and why:** In `app_top_bar.dart`, I built the shared top bar used on the app screens.

#### Case 3 - Shared bottom navigation

- **File:** `lib/widgets/app_bottom_nav.dart`
- **Commit:** [All Screens](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/b181c74723edec9d8444fc76626b76751b121696); [navigation revisions](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)
- **What I wrote and why:** In `app_bottom_nav.dart`, I built and revised the shared bottom navigation and its routes.

#### Case 4 - Course Page and professor card changes

- **Files:** `lib/screens/course_page.dart` and `lib/widgets/professor_card.dart`
- **Commit:** [Course Page and professor card revisions](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/ee7de7b90af27c8e60de2da6e53ce78548827d41)
- **What I wrote and why:** In `course_page.dart` and the professor card code, I changed the layout, color placement, and rating details. I should identify the specific parts I wrote before counting those files as my own work.

### The AI-written part I understand best

- **File:** `lib/models/professor.dart`
- **Commit:** [Course Page Rough Draft](https://github.com/codewchester/RateMyProfessorHAU-Finals/commit/6895fb4fc40eece33e3d6f3c31fd25cde5e479ef)
- **What it does and why we kept it:** The `Professor` model groups the information used by the course and review screens, such as a professor's name, department, rating, courses, and contact details. The sample professor list gives the UI records to display while a database is not connected. Keeping the data in a model makes the screens and cards easier to build around consistent fields. These are sample records, not a live directory.
