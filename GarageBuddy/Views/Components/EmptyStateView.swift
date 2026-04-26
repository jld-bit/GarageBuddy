import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(AppTheme.secondaryAccent)
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.75))
                .padding(.horizontal, 24)
        }
        .padding(.vertical, 28)
        .frame(maxWidth: .infinity)
        .background(AppTheme.cardBackground, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
