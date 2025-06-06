import SwiftUI

enum LoginNavigation: Hashable {
    case root
    case invest(Datum)
    case redeem(Datum)
    case redeemSummary
    case otpScreen
    case support
}

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ destination: LoginNavigation) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
