import SwiftUI

struct ContentView: View {
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var lunchStartTime = Date()
    @State private var lunchEndTime = Date()
    @State private var hourlyRate = ""
    @State private var totalHours = 0.0
    @State private var totalAmount = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Text("Start Time")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)
                Picker("", selection: $startTime) {
                    Text("AM").tag(Calendar.current.date(bySettingHour: startTime.hour(), minute: startTime.minute(), second: 0, of: startTime)!)
                    Text("PM").tag(Calendar.current.date(bySettingHour: startTime.hour() + 12, minute: startTime.minute(), second: 0, of: startTime)!)
                }
                .pickerStyle(.segmented)
            }
            
            Text("Lunch Start Time")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                DatePicker("", selection: $lunchStartTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)
                Picker("", selection: $lunchStartTime) {
                    Text("AM").tag(Calendar.current.date(bySettingHour: lunchStartTime.hour(), minute: lunchStartTime.minute(), second: 0, of: lunchStartTime)!)
                    Text("PM").tag(Calendar.current.date(bySettingHour: lunchStartTime.hour() + 12, minute: lunchStartTime.minute(), second: 0, of: lunchStartTime)!)
                }
                .pickerStyle(.segmented)
            }
            
            Text("ELunch End Time")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                DatePicker("", selection: $lunchEndTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)
                Picker("", selection: $lunchEndTime) {
                    Text("AM").tag(Calendar.current.date(bySettingHour: lunchEndTime.hour(), minute: lunchEndTime.minute(), second: 0, of: lunchEndTime)!)
                    Text("PM").tag(Calendar.current.date(bySettingHour: lunchEndTime.hour() + 12, minute: lunchEndTime.minute(), second: 0, of: lunchEndTime)!)
                }
                .pickerStyle(.segmented)
            }
            
            Text("End Time")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                DatePicker("", selection: $endTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)
                Picker("", selection: $endTime) {
                    Text("AM").tag(Calendar.current.date(bySettingHour: endTime.hour(), minute: endTime.minute(), second: 0, of: endTime)!)
                    Text("PM").tag(Calendar.current.date(bySettingHour: endTime.hour() + 12, minute: endTime.minute(), second: 0, of: endTime)!)
                }
                .pickerStyle(.segmented)
            }
            
            Button("Calculate Hours") {
                let workComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime, to: endTime)
                let lunchComponents = Calendar.current.dateComponents([.hour, .minute], from: lunchStartTime, to: lunchEndTime)
                
                if let workHours = workComponents.hour, let workMinutes = workComponents.minute,
                   let lunchHours = lunchComponents.hour, let lunchMinutes = lunchComponents.minute {
                    totalHours = Double(workHours) + Double(workMinutes) / 60.0
                    let lunchTime = Double(lunchHours) + Double(lunchMinutes) / 60.0
                    totalHours -= lunchTime
                }
                
                dismissKeyboard()
            }
            .buttonStyle(.borderedProminent)
            
            Text("Total Hours: \(totalHours, specifier: "%.2f")")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Hourly Rate")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Hourly Rate", text: $hourlyRate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Button("Calculate Total") {
                if let rate = Double(hourlyRate) {
                    totalAmount = totalHours * rate
                }
                
                // Dismiss keyboard after pressing the button
                dismissKeyboard()
            }
            .buttonStyle(.borderedProminent)
            
            Text("Total Amount: \(totalAmount, specifier: "%.2f")")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

extension Date {
    func hour() -> Int {
        return Calendar.current.component(.hour, from: self) % 12
    }

    func minute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
}

#Preview {
    ContentView()
}
