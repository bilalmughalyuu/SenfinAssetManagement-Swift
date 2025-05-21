import SwiftUI

struct InvestScreen: View {
    let fund: Datum
    var body: some View {
        Text("Invest in \(fund.fundName)")
    }
}
