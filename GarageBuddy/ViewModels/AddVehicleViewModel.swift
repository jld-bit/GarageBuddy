import Foundation

@MainActor
final class AddVehicleViewModel: ObservableObject {
    @Published var year: Int = Calendar.current.component(.year, from: .now)
    @Published var make = ""
    @Published var model = ""
    @Published var odometer = ""
    @Published var plateOrNickname = ""
    @Published var photoData: Data?

    var isValid: Bool {
        !make.isEmpty && !model.isEmpty && Int(odometer) != nil && !plateOrNickname.isEmpty
    }

    func buildVehicle() -> Vehicle? {
        guard let odo = Int(odometer), isValid else { return nil }
        return Vehicle(
            year: year,
            make: make,
            model: model,
            odometer: odo,
            plateOrNickname: plateOrNickname,
            photoData: photoData
        )
    }
}
