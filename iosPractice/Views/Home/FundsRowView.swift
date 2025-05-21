import SwiftUI

struct FundRowView: View {
    let fund: Datum
    @State private var isActive = false
    
    var body: some View {
        
        
        
        let totalCost = fund.accounts.reduce(0.0) { $0 + (Double($1.cost) ?? 0.0) }
        let totalMarketValue = fund.accounts.reduce(0.0) { $0 + (Double($1.marketValue) ?? 0.0) }
        
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(fund.fundName)
                        .font(.system(size: 18, weight: .light))
                    Spacer()
                    Text(String(format: "%.2f", totalMarketValue))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#37BC71"))
                }
                
                HStack {
                    Text("You invested")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                    Spacer()
                    Text(String(format: "%.2f", totalCost))
                        .foregroundColor(Color.gray)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Buy at \(String(format: "%.2f", Double(fund.creationPrice) ?? 0.0))")
                            .font(.system(size: 12, weight: .regular))
                        
                        Text("Invest")
                            .foregroundColor(Color.white)
                            .font(.caption)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 6)
                            .background(Color(hex: "#2a6877"))
                            .cornerRadius(8)
                            .opacity(1)
                    }
                    
                    Spacer().frame(width: 24)
                    
                    VStack(alignment: .leading) {
                        Text("Sell at \(String(format: "%.2f", Double(fund.redimPrice) ?? 0.0))")
                            .font(.system(size: 12, weight: .regular))
                        
                        Button(action: {
                            isActive = true
                        }) {
                            Text("Redeem")
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 6)
                                .background(Color(hex: "#de5353"))
                                .cornerRadius(8)
                        }
                        .background(
                            NavigationLink("", destination: RedeemScreen(fund: fund), isActive: $isActive)
                                .hidden()
                        )
                        
                        //                        NavigationLink(destination: RedeemScreen(fund: fund)) {
                        //                            Text("Redeem")
                        //                                .foregroundColor(.white)
                        //                                .font(.caption)
                        //                                .padding(.horizontal, 24)
                        //                                .padding(.vertical, 6)
                        //                                .background(Color(hex: "#de5353"))
                        //                                .cornerRadius(8)
                        //                        }
                        //                        .buttonStyle(PlainButtonStyle())
                        //                        .contentShape(Rectangle())
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            
            HStack {
                Spacer()
                Image("cardBackground")
                    .resizable()
                    .frame(width: 80)
                    .padding(.trailing, -14)
                    .clipped()
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
        .layoutPriority(1)
    }
}

#Preview("Single Fund Row") {
    FundRowView(
        fund: Datum(
            fundCode: "10",
            fundName: "Senfin Growth Fund",
            priceDate: "2024-09-05",
            creationPrice: "14.370000",
            redimPrice: "13.960000",
            type: "2",
            color: "#B40431",
            accounts: [
                Account(
                    accountNo: "0015602792121001",
                    blockNoOfUnit: "0.00",
                    pendingNoOfUnit: "0.00",
                    noOfUnits: "189.50",
                    transactionUnits: "189.50",
                    redimPrice: "13.96",
                    marketValue: "2645.42",
                    name: nil,
                    cost: "1500.00"
                )
            ]
        )
    )
}
