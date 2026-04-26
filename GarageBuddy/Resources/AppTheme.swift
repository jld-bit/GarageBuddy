import SwiftUI

enum AppTheme {
    static let accent = Color(red: 0.98, green: 0.30, blue: 0.24)
    static let secondaryAccent = Color(red: 0.14, green: 0.65, blue: 0.89)
    static let cardBackground = Color(red: 0.12, green: 0.14, blue: 0.20)
    static let pageBackground = LinearGradient(
        colors: [Color(red: 0.07, green: 0.08, blue: 0.14), Color(red: 0.11, green: 0.11, blue: 0.19)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
