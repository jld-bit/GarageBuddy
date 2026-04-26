import Foundation
import SwiftData

enum ServiceType: String, CaseIterable, Codable, Identifiable {
    case oilChange = "Oil Change"
    case tireRotation = "Tire Rotation"
    case brakeService = "Brake Service"
    case inspection = "Inspection"
    case battery = "Battery"
    case other = "Other"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .oilChange: return "drop.fill"
        case .tireRotation: return "circle.dotted"
        case .brakeService: return "brakesignal"
        case .inspection: return "checkmark.shield.fill"
        case .battery: return "battery.100percent"
        case .other: return "wrench.and.screwdriver.fill"
        }
    }
}

@Model
final class ServiceLog {
    var id: UUID
    var typeRaw: String
    var date: Date
    var odometer: Int
    var cost: Double
    var notes: String

    // Placeholder architecture for future file/photo docs.
    var attachmentIDs: [String]

    var vehicle: Vehicle?

    init(
        id: UUID = UUID(),
        type: ServiceType,
        date: Date,
        odometer: Int,
        cost: Double,
        notes: String,
        attachmentIDs: [String] = [],
        vehicle: Vehicle? = nil
    ) {
        self.id = id
        self.typeRaw = type.rawValue
        self.date = date
        self.odometer = odometer
        self.cost = cost
        self.notes = notes
        self.attachmentIDs = attachmentIDs
        self.vehicle = vehicle
    }

    var type: ServiceType {
        get { ServiceType(rawValue: typeRaw) ?? .other }
        set { typeRaw = newValue.rawValue }
    }
}
