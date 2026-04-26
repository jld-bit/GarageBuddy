import Foundation
import SwiftData

enum PreviewData {
    static var sampleContainer: ModelContainer {
        let schema = Schema([
            Vehicle.self,
            ServiceLog.self,
            MaintenanceReminder.self
        ])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [config])

        let sedan = Vehicle(year: 2020, make: "Nova", model: "Sedan X", odometer: 52840, plateOrNickname: "Daily")
        let suv = Vehicle(year: 2018, make: "TrailForge", model: "Atlas", odometer: 88420, plateOrNickname: "Weekend")

        let oil = ServiceLog(type: .oilChange, date: .now.addingTimeInterval(-86400 * 60), odometer: 50000, cost: 69.99, notes: "Synthetic 5W-30", vehicle: sedan)
        let brakes = ServiceLog(type: .brakeService, date: .now.addingTimeInterval(-86400 * 120), odometer: 86000, cost: 380, notes: "Front pads replaced", vehicle: suv)

        let reminder1 = MaintenanceReminder(title: "Oil change", triggerType: .mileage, dueMileage: 55000, vehicle: sedan)
        let reminder2 = MaintenanceReminder(title: "Annual inspection", triggerType: .date, dueDate: .now.addingTimeInterval(-86400 * 2), vehicle: suv)

        sedan.serviceLogs = [oil]
        suv.serviceLogs = [brakes]
        sedan.reminders = [reminder1]
        suv.reminders = [reminder2]

        [sedan, suv, oil, brakes, reminder1, reminder2].forEach { container.mainContext.insert($0) }

        return container
    }
}
