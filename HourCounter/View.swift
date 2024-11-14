import SwiftUI

// Extensión para resignar el primer respondedor
extension View {
    func dismissKeyboard() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
}
