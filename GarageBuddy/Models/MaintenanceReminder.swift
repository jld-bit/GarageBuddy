import Foundation
import SwiftData

enum ReminderTriggerType: String, CaseIterable, Codable, Identifiable {
    case date
    case mileage

    var id: String { rawValue }
}

@Model
final class MaintenanceReminder {
    var id: UUID
    var title: String
    var triggerTypeRaw: String
    var dueDate: Date?
    var dueMileage: Int?
    var isCompleted: Bool

    var vehicle: Vehicle?

    init(
        id: UUID = UUID(),
        title: String,
        triggerType: ReminderTriggerType,
        dueDate: Date? = nil,
        dueMileage: Int? = nil,
        isCompleted: Bool = false,
        vehicle: Vehicle? = nil
    ) {
        self.id = id
        self.title = title
        self.triggerTypeRaw = triggerType.rawValue
        self.dueDate = dueDate
        self.dueMileage = dueMileage
        self.isCompleted = isCompleted
        self.vehicle = vehicle
    }

    var triggerType: ReminderTriggerType {
        get { ReminderTriggerType(rawValue: triggerTypeRaw) ?? .date }
        set { triggerTypeRaw = newValue.rawValue }
    }

    func isDue(currentMileage: Int, today: Date = .now) -> Bool {
        if isCompleted { return false }
        switch triggerType {
        case .date:
            guard let dueDate else { return false }
            return dueDate <= today
        case .mileage:
            guard let dueMileage else { return false }
            return currentMileage >= dueMileage
        }
    }
}
