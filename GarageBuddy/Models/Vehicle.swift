import Foundation
import SwiftData

@Model
final class Vehicle {
    var id: UUID
    var createdAt: Date
    var year: Int
    var make: String
    var model: String
    var odometer: Int
    var plateOrNickname: String
    var photoData: Data?

    @Relationship(deleteRule: .cascade, inverse: \ServiceLog.vehicle)
    var serviceLogs: [ServiceLog] = []

    @Relationship(deleteRule: .cascade, inverse: \MaintenanceReminder.vehicle)
    var reminders: [MaintenanceReminder] = []

    init(
        id: UUID = UUID(),
        createdAt: Date = .now,
        year: Int,
        make: String,
        model: String,
        odometer: Int,
        plateOrNickname: String,
        photoData: Data? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.year = year
        self.make = make
        self.model = model
        self.odometer = odometer
        self.plateOrNickname = plateOrNickname
        self.photoData = photoData
    }

    var displayName: String {
        "\(year) \(make) \(model)"
    }
}
