import Foundation
import SwiftData

@MainActor
final class GarageViewModel: ObservableObject {
    func canAddVehicle(currentCount: Int, isPremium: Bool) -> Bool {
        isPremium || currentCount < 2
    }

    func canAddServiceLog(currentCount: Int, isPremium: Bool) -> Bool {
        isPremium || currentCount < 20
    }

    func expenseTotal(for vehicle: Vehicle) -> Double {
        vehicle.serviceLogs.reduce(0) { $0 + $1.cost }
    }

    func dueReminders(for vehicle: Vehicle, today: Date = .now) -> [MaintenanceReminder] {
        vehicle.reminders.filter { $0.isDue(currentMileage: vehicle.odometer, today: today) }
    }

    func daysUntil(_ date: Date, from now: Date = .now) -> Int {
        Calendar.current.dateComponents([.day], from: now.startOfDay, to: date.startOfDay).day ?? 0
    }
}

private extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
