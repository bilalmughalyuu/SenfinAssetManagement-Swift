import SwiftUI

struct RedeemScreen: View {
    let fund: Datum

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Redeem Fund")
                .font(.title)

            Text("Fund Name: \(fund.fundName)")
            Text("Fund Code: \(fund.fundCode)")
            // Add more info from `fund` as needed

            Spacer()
        }
        .padding()
        .navigationTitle("Redeem")
    }
}

