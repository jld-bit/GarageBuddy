import SwiftUI
import SwiftData

struct RootTabView: View {
    @StateObject private var premiumManager = PremiumManager()

    var body: some View {
        TabView {

            GarageScreen()
                .tabItem {
                    Label("Garage", systemImage: "car.2.fill")
                }

            RemindersScreen()
                .tabItem {
                    Label("Reminders", systemImage: "bell.badge.fill")
                }

            ExpensesScreen()
                .tabItem {
                    Label("Expenses", systemImage: "dollarsign.circle.fill")
                }

            PremiumScreen()
                .environmentObject(premiumManager)
                .tabItem {
                    Label("Premium", systemImage: "crown.fill")
                }
        }
        .environmentObject(premiumManager)
        .task {
            premiumManager.applyEntitlementsForDebug()
            await premiumManager.loadProducts()
        }
    }
}

#Preview {
    RootTabView()
        .modelContainer(PreviewData.sampleContainer)
}
