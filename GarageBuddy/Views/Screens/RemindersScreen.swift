import SwiftUI
import SwiftData

struct RemindersScreen: View {
    @Query(sort: \\Vehicle.createdAt) private var vehicles: [Vehicle]

    private var dueItems: [(Vehicle, MaintenanceReminder)] {
        vehicles.flatMap { vehicle in
            vehicle.reminders
                .filter { $0.isDue(currentMileage: vehicle.odometer) }
                .map { (vehicle, $0) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.pageBackground.ignoresSafeArea()
                if dueItems.isEmpty {
                    EmptyStateView(
                        icon: "checkmark.seal.fill",
                        title: "All Caught Up",
                        subtitle: "You have no due maintenance reminders right now."
                    )
                    .padding()
                } else {
                    List(dueItems, id: \.1.id) { vehicle, reminder in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(reminder.title)
                                .font(.headline)
                            Text(vehicle.displayName)
                                .font(.subheadline)
                            if let dueMileage = reminder.dueMileage {
                                Text("Due at \(dueMileage.formatted()) mi")
                                    .font(.caption)
                            }
                            if let dueDate = reminder.dueDate {
                                Text(dueDate, style: .date)
                                    .font(.caption)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Due Soon")
        }
    }
}

#Preview {
    RemindersScreen()
        .modelContainer(PreviewData.sampleContainer)
}
