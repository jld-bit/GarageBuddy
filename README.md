# GarageBuddy (SwiftUI + SwiftData)

GarageBuddy is an original, local-first iPhone app concept for tracking vehicle maintenance reminders and service history.

## Legal + originality notice
This project is intentionally designed with original naming, copy, layouts, and UI styling. Do **not** copy protected branding, copyrighted assets, trade dress, screenshots, or exact UX from other apps.

## Highlights
- SwiftUI app structure with MVVM-oriented view models.
- SwiftData local persistence for vehicles, service logs, and reminders.
- Vehicle fields: photo, year, make, model, odometer, plate/nickname.
- Service logs: service type, date, odometer, cost, notes.
- Reminder engine supports date-based and mileage-based due logic.
- Expense summary by vehicle.
- StoreKit 2 premium architecture (free limits + premium unlock path).
- Attachment ID placeholder architecture for future document/photo uploads.
- Preview/sample data and reusable UI components.

## Suggested free vs premium behavior
- Free:
  - Up to 2 vehicles.
  - Up to 20 service logs total.
- Premium:
  - Unlimited vehicles + logs.
  - Advanced reminders.
  - Expense reports and themes.

## Project structure
- `GarageBuddy/Models` — SwiftData models and enums.
- `GarageBuddy/ViewModels` — MVVM logic for validation and business rules.
- `GarageBuddy/Views` — tab shell, screens, and reusable components.
- `GarageBuddy/Services` — StoreKit 2 premium manager.
- `GarageBuddy/Preview` — in-memory sample data container.

## Next steps for production
1. Add Xcode project scaffolding (`.xcodeproj`) and app assets.
2. Replace debug entitlement stubs with full StoreKit transaction observation and restore flow.
3. Add service-log creation/edit screens and vehicle detail timeline.
4. Add actual attachment storage (sandbox files + metadata model).
5. Add tests for reminder due logic and premium gating behavior.
