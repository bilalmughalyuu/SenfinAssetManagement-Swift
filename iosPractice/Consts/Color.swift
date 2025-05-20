import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "37BC71")
    static let secondaryColor = Color(hex: "2a6877")
    static let backgroundColor = Color(hex: "FAFAFA")
    static let borderColor = Color(hex: "E9E8E8")
    static let grayColor = Color(hex: "808080")
    static let headingColor = Color(hex: "27272a")
    static let textColor = Color(hex: "52525c")
    static let redColor = Color(hex: "de5353")
    static let brightRed = Color(hex: "F34826")
    static let brightGreen = Color(hex: "06AA06")
    static let mediumGray = Color(hex: "B1AFAF")
    static let lightGray = Color(hex: "F5F5F5")
    static let whiteColor = Color(hex: "ffffff")
    static let blackColor = Color(hex: "000000")
    static let disableRed = Color(hex: "b7aeae")

    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
