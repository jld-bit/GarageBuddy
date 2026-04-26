import PhotosUI
import SwiftUI
import SwiftData

struct GarageScreen: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var premiumManager: PremiumManager
    @Query(sort: \\Vehicle.createdAt, order: .reverse) private var vehicles: [Vehicle]
    @StateObject private var viewModel = GarageViewModel()
    @State private var showAddVehicle = false

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.pageBackground.ignoresSafeArea()

                Group {
                    if vehicles.isEmpty {
                        EmptyStateView(
                            icon: "car.fill",
                            title: "Your Garage is Empty",
                            subtitle: "Add your first vehicle to track maintenance and upcoming service reminders."
                        )
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(vehicles) { vehicle in
                                    VehicleCard(vehicle: vehicle)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("GarageBuddy")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddVehicle = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(!viewModel.canAddVehicle(currentCount: vehicles.count, isPremium: premiumManager.isPremium))
                }
            }
            .sheet(isPresented: $showAddVehicle) {
                AddVehicleSheet { vehicle in
                    modelContext.insert(vehicle)
                }
            }
        }
    }
}

private struct VehicleCard: View {
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(vehicle.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
                Text(vehicle.plateOrNickname)
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(AppTheme.secondaryAccent.opacity(0.25), in: Capsule())
                    .foregroundStyle(AppTheme.secondaryAccent)
            }
            Text("Odometer: \(vehicle.odometer.formatted()) mi")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
            StatCard(
                title: "Service Logs",
                value: "\(vehicle.serviceLogs.count)",
                progress: min(Double(vehicle.serviceLogs.count) / 20, 1),
                color: AppTheme.accent
            )
        }
        .padding()
        .background(AppTheme.cardBackground, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

private struct AddVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddVehicleViewModel()
    @State private var selectedItem: PhotosPickerItem?
    let onSave: (Vehicle) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Vehicle") {
                    TextField("Year", value: $viewModel.year, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Make", text: $viewModel.make)
                    TextField("Model", text: $viewModel.model)
                    TextField("Odometer", text: $viewModel.odometer)
                        .keyboardType(.numberPad)
                    TextField("Plate or Nickname", text: $viewModel.plateOrNickname)
                }

                Section("Photo") {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Select Vehicle Photo", systemImage: "photo")
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppTheme.pageBackground)
            .navigationTitle("Add Vehicle")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let vehicle = viewModel.buildVehicle() {
                            onSave(vehicle)
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
            }
            .task(id: selectedItem) {
                guard let data = try? await selectedItem?.loadTransferable(type: Data.self) else { return }
                viewModel.photoData = data
            }
        }
    }
}

#Preview {
    GarageScreen()
        .environmentObject(PremiumManager())
        .modelContainer(PreviewData.sampleContainer)
}
