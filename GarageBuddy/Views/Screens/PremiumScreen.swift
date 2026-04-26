import SwiftUI

struct PremiumScreen: View {
    @EnvironmentObject private var premiumManager: PremiumManager

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.pageBackground.ignoresSafeArea()

                VStack(spacing: 16) {
                    StatCard(
                        title: "Plan",
                        value: premiumManager.isPremium ? "GarageBuddy Premium" : "Free",
                        progress: premiumManager.isPremium ? 1 : 0.3,
                        color: .yellow
                    )

                    benefitRow("Unlimited vehicles and service logs")
                    benefitRow("Advanced reminder rules and mileage nudges")
                    benefitRow("Expense reports and export-ready summaries")
                    benefitRow("Custom color themes")

                    Button {
                        Task { await premiumManager.purchasePremium() }
                    } label: {
                        Text("Upgrade with StoreKit 2")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(AppTheme.accent)
                    .disabled(premiumManager.isPremium)

                    Text("StoreKit 2 only. No third-party paywalls.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding()
            }
            .navigationTitle("Premium")
        }
    }

    @ViewBuilder
    private func benefitRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(AppTheme.secondaryAccent)
            Text(text)
                .foregroundStyle(.white)
            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    PremiumScreen()
        .environmentObject(PremiumManager())
}
