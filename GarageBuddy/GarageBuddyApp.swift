import SwiftUI
import SwiftData

@main
struct GarageBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .tint(AppTheme.accent)
        }
        .modelContainer(for: [Vehicle.self, ServiceLog.self, MaintenanceReminder.self])
    }
}
