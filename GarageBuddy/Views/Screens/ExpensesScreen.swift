import SwiftUI
import SwiftData

struct ExpensesScreen: View {
    @Query(sort: \\Vehicle.createdAt) private var vehicles: [Vehicle]

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.pageBackground.ignoresSafeArea()

                if vehicles.isEmpty {
                    EmptyStateView(
                        icon: "dollarsign.circle",
                        title: "No Expenses Yet",
                        subtitle: "Add vehicles and service logs to see your maintenance spend."
                    )
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vehicles) { vehicle in
                                let total = vehicle.serviceLogs.reduce(0.0) { $0 + $1.cost }
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(vehicle.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("Total: \(total, format: .currency(code: Locale.current.currency?.identifier ?? \"USD\"))")
                                        .foregroundStyle(AppTheme.secondaryAccent)
                                    Text("\(vehicle.serviceLogs.count) services logged")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.75))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(AppTheme.cardBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Expense Summary")
        }
    }
}

#Preview {
    ExpensesScreen()
        .modelContainer(PreviewData.sampleContainer)
}
