# Product Requirements Document (PRD)
## Mood Journal App - MVP

---

## 1. Product Overview

### 1.1 Product Vision
A minimalist iOS journal and mood tracking app that helps users reflect on their daily experiences, track emotional patterns, and build consistent journaling habits.

### 1.2 Target Platform
- **Platform:** iOS 17+
- **Framework:** SwiftUI
- **Data Persistence:** SwiftData
- **Future Support:** Apple Watch (post-MVP)

### 1.3 Target Audience
- Individuals interested in mental wellness and self-reflection
- Users seeking a simple, beautiful journaling experience
- People who want to track mood patterns over time

---

## 2. Authentication & Onboarding

### 2.1 Authentication Methods
- **Sign in with Apple** (primary)
- **Google Sign-In** (secondary)
- Email/password (optional for future consideration)

### 2.2 Onboarding Flow
- Welcome screen with app value proposition
- Permission requests (notifications, photo library access if needed)
- Brief tutorial on how to create first entry
- Mood selection explanation
- Tag system introduction

---

## 3. Core Features

### 3.1 Journal Entry Creation

#### Entry Components
- **Text:** Rich text journal entry (main content)
- **Mood:** 5-level mood selection (required)
- **Location:** Optional location tagging
- **Photos:** Photo library access (FUTURE - not in MVP)
- **Timestamp:** Automatic date/time capture

#### Entry Actions
- Create new entry
- Edit existing entry
- Delete entry (with confirmation)
- Save as draft (optional future feature)

### 3.2 Mood System

#### Mood Levels (5 options)
1. Very Bad / Terrible
2. Bad / Down
3. Neutral / Okay
4. Good / Happy
5. Great / Excellent

**Visual Representation:** 
- Emoji-based or color-coded
- Each mood has associated color for calendar/visualization

**Requirements:**
- Mood selection is mandatory for each entry
- Moods should be quickly selectable (one tap)

### 3.3 Tagging System

#### Automatic Tags
- Text (if text content exists)
- Location (if location added)
- Photo (if photo attached) - FUTURE

#### Custom Tags
- Users can create custom tags
- Users can add multiple tags per entry
- Users can edit tag names
- Users can delete tags
- Tag suggestions based on frequently used tags (future enhancement)

#### Tag Management
- Tag library/list view
- Ability to rename tags globally
- Ability to merge duplicate tags
- Color coding for tags (optional future feature)

---

## 4. App Structure & Navigation

### 4.1 Navigation Pattern
**Floating Tab Bar** (bottom of screen)

#### Tabs (Left to Right):
1. **Home** - Main feed/dashboard
2. **Calendar** - Monthly/yearly calendar view
3. **Stats** - Analytics and insights
4. **+ (Plus Button)** - Create new entry (separated/prominent design)

### 4.2 Home View
- Recent entries list/feed
- Quick mood overview
- Current streak display
- Quick access to today's entry (if exists)
- Motivational prompt if no entry today

### 4.3 Calendar View
- Monthly calendar grid
- Each day colored by mood (if entry exists)
- Tap day to view entry
- Swipe between months
- Yearly overview option (zoomed out view)

### 4.4 Stats View
**MVP Metrics:**
- Average mood this week
- Current streak (consecutive days with entries)
- Total entries count
- Mood distribution chart (percentage of each mood level)

**Future Considerations:**
- Longest streak
- Most productive time of day
- Most common tags
- Monthly comparisons
- Mood trends over time (line graph)

---

## 5. Widget Support

### 5.1 Widget Types
- **Small Widget:** Current streak or mood summary
- **Medium Widget:** Today's entry preview or reminder
- **Large Widget:** Week overview with mood colors

### 5.2 Widget States
- **No Entry Today:** Reminder message (e.g., "Take a moment to reflect")
- **Entry Exists:** Show entry tags, headline/preview, or streak progression
- **Inspiration:** Duolingo-style streak visualization

### 5.3 Widget Interaction
- Tap to open app to entry creation or today's entry

---

## 6. Notifications & Reminders

### 6.1 Daily Reminders
- Customizable reminder time
- Reminder frequency (daily, specific days)
- Reminder message customization (optional)

### 6.2 Notification Types
- Daily journal reminder
- Streak milestone celebrations (e.g., 7 days, 30 days)
- Weekly mood summary (optional)

### 6.3 Settings
- Enable/disable notifications
- Set reminder time
- Select reminder days
- Notification preview/test

---

## 7. Data & Privacy

### 7.1 Data Storage
- **Primary:** SwiftData (local)
- **Sync:** iCloud sync for cross-device support
- **Future:** Photo storage optimization for iCloud

### 7.2 Data Management
- Export entries (PDF, JSON, or CSV format)
- Data backup to iCloud
- Account deletion with data removal

### 7.3 Privacy
- All data encrypted at rest
- No third-party data sharing
- Local-first approach
- iCloud private database

### 7.4 Permissions
- Notifications (for reminders)
- Location Services (optional, for location tagging)
- Photo Library (for future photo feature)

---

## 8. Design System

### 8.1 Theme Support
- **Light Mode:** Full support
- **Dark Mode:** Full support
- Automatic system theme switching

### 8.2 Color Scheme
**Base Colors:**
- White (light mode background)
- Black (dark mode background)

**Accent Color:**
- User-selectable from predefined palette
- Options: 5-8 carefully curated colors
- Applied to buttons, selections, mood highlights

**Mood Colors:**
- 5 distinct colors for mood levels
- Consistent across calendar, charts, and UI
- Accessible contrast ratios

### 8.3 Typography
- SF Pro (system font) for consistency
- Clear hierarchy (headlines, body, captions)
- Readable font sizes
- Support for Dynamic Type

### 8.4 UI Principles
- Minimalist and clean
- Focus on content
- Smooth animations and transitions
- Generous white space
- Thumb-friendly tap targets

---

## 9. Monetization Model

### 9.1 Free Tier (MVP)
**Limitations:**
- Maximum 10-20 entries per month
- Basic mood tracking
- Limited tag creation (e.g., 5 custom tags)
- One mood reminder per day
- Basic stats (current week only)
- No data export

### 9.2 Premium Subscription
**Features:**
- Unlimited entries
- Unlimited custom tags
- Advanced statistics (all-time data, trends, comparisons)
- Multiple daily reminders
- Data export (PDF, CSV, JSON)
- Photo attachments (when feature launches)
- Priority support
- Future features as they release

### 9.3 Pricing Strategy (TBD)
- Monthly subscription: $2.99 - $4.99
- Annual subscription: $19.99 - $29.99 (best value)
- Free trial: 7-14 days
- Family sharing support (consideration)

---

## 10. Technical Requirements

### 10.1 Minimum Requirements
- iOS 17.0+
- iPhone (optimized for all sizes)
- iPad support (optional, but should be considered)

### 10.2 Technologies
- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI
- **Data:** SwiftData
- **Authentication:** 
  - AuthenticationServices (Sign in with Apple)
  - Google Sign-In SDK
- **Cloud:** CloudKit (for iCloud sync)
- **Widgets:** WidgetKit
- **Notifications:** UserNotifications framework
- **Location:** CoreLocation (optional)

### 10.3 Performance Goals
- App launch time: < 2 seconds
- Entry save time: < 1 second
- Smooth 60fps animations
- Widget update: < 15 seconds
- Offline-first functionality

---

## 11. Development Phases

### Phase 1: MVP Core (Weeks 1-4)
- [ ] Authentication (Sign in with Apple)
- [ ] Basic entry creation (text + mood)
- [ ] SwiftData models and persistence
- [ ] Home feed view
- [ ] Basic navigation structure

### Phase 2: Enhanced Features (Weeks 5-8)
- [ ] Tag system (auto + custom)
- [ ] Calendar view with mood colors
- [ ] Entry editing and deletion
- [ ] Location tagging
- [ ] Google Sign-In integration

### Phase 3: Engagement & Polish (Weeks 9-12)
- [ ] Notifications and reminders
- [ ] Stats page with basic analytics
- [ ] Widget implementation
- [ ] iCloud sync
- [ ] Light/dark mode refinement
- [ ] Accent color selection

### Phase 4: Monetization & Launch (Weeks 13-16)
- [ ] Free tier limitations implementation
- [ ] Subscription system (StoreKit 2)
- [ ] Paywall UI
- [ ] Data export feature
- [ ] Onboarding flow
- [ ] App Store assets and submission
- [ ] Beta testing (TestFlight)

---

## 12. Success Metrics (Post-Launch)

### 12.1 Engagement Metrics
- Daily Active Users (DAU)
- Weekly Active Users (WAU)
- Average entries per user per week
- Streak retention (% of users with 7+ day streaks)

### 12.2 Conversion Metrics
- Free to paid conversion rate
- Trial to paid conversion rate
- Churn rate
- Average revenue per user (ARPU)

### 12.3 Quality Metrics
- App Store rating (target: 4.5+)
- Crash-free rate (target: 99%+)
- Average session duration

---

## 13. Future Enhancements (Post-MVP)

### 13.1 Features to Consider
- Photo attachments in entries
- Voice notes
- Apple Watch companion app
- Mood patterns AI insights
- Social sharing (optional, with privacy controls)
- Journaling prompts and templates
- Markdown support for text entries
- Entry search functionality
- Tag-based filtering
- Dark patterns/themes beyond basic dark mode
- Customizable mood levels (3, 5, or 7 options)
- Integration with Apple Health (mindful minutes)
- End-to-end encryption option
- Multiple journals/notebooks
- Collaborative journaling (shared with family/therapist)

### 13.2 Platform Expansion
- iPad optimization with split view
- macOS app (Catalyst or native)
- Apple Watch standalone app
- Apple Vision Pro consideration

---

## 14. Open Questions & Decisions Needed

### 14.1 Design Decisions
- [ ] Exact mood level naming and emoji choices
- [ ] Specific accent color palette (5-8 colors)
- [ ] Widget layout variations
- [ ] Onboarding screen count and content
- [ ] Entry text editor features (formatting, word count, etc.)

### 14.2 Feature Decisions
- [ ] Maximum character limit for entries (if any)
- [ ] Maximum photos per entry (future)
- [ ] Default reminder time
- [ ] Free tier entry limit (10, 20, or 30 per month?)
- [ ] Should deleted entries go to trash or delete immediately?

### 14.3 Technical Decisions
- [ ] iCloud sync strategy (full sync vs. selective)
- [ ] Handling sync conflicts
- [ ] Photo storage optimization approach
- [ ] Analytics tool selection (privacy-focused)
- [ ] Crash reporting tool

### 14.4 Business Decisions
- [ ] Final subscription pricing
- [ ] Free trial duration
- [ ] Launch marketing strategy
- [ ] Target launch date
- [ ] App name (final decision)
- [ ] App Store keyword strategy

---

## 15. Risks & Mitigations

### 15.1 Technical Risks
**Risk:** iCloud sync conflicts causing data loss
**Mitigation:** Implement robust conflict resolution, regular backups, thorough testing

**Risk:** Performance issues with large entry counts
**Mitigation:** Pagination, lazy loading, data indexing

### 15.2 Business Risks
**Risk:** Low free-to-paid conversion
**Mitigation:** Carefully balance free tier limitations, compelling premium features

**Risk:** High subscription churn
**Mitigation:** Continuous feature updates, excellent user experience, responsive support

### 15.3 User Experience Risks
**Risk:** Users finding the app too simple
**Mitigation:** Focus on polish and delightful interactions, gather feedback early

**Risk:** Notification fatigue
**Mitigation:** Make reminders easily customizable and dismissible

---

## 16. Compliance & Legal

### 16.1 App Store Requirements
- Privacy Policy (required before submission)
- Terms of Service
- App Store Review Guidelines compliance
- Privacy nutrition label (App Store)

### 16.2 Privacy Regulations
- GDPR compliance (data export, deletion)
- CCPA compliance (California users)
- Clear data usage disclosure

### 16.3 Subscription Requirements
- Clear subscription terms
- Easy cancellation process
- Restore purchases functionality
- Family Sharing support (if applicable)

---

## Document Version
**Version:** 1.0  
**Last Updated:** November 28, 2025  
**Status:** Draft - Ready for Development

## Next Steps
1. Review and finalize open questions
2. Create detailed wireframes/mockups
3. Set up development environment
4. Initialize SwiftData models
5. Begin Phase 1 development
