import SwiftUI

struct TransactionRow: View {
    var transaction: TransactionModel
    var tab: Int
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text((tab == 0 ? transaction.accountNo : transaction.fundName ?? "") ?? "")
                        .font(.subheadline)
                    Spacer()
                    Text(transaction.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.primaryColor)
                }
                
                Group {
                    if tab == 0 {
                        HStack {
                            Text("Transaction Units: \(transaction.transactedUnits ?? "")")
                                .font(.system(size: 12))
                            Spacer()
                            Text("Price: \(transaction.offerBidPrice ?? "")")
                                .font(.system(size: 12))
                        }
                    } else {
                        HStack {
                            Text(transaction.accountNo ?? "")
                                .font(.system(size: 12))
                        }
                    }
                }

                
                if tab == 0 {
                    HStack {
                        Text("Amount (LKR):")
                        Spacer()
                        Text(transaction.amountApplied ?? "-")
                    }
                }
                
                if tab == 1 {
                    if let amount = transaction.amount, !amount.isEmpty {
                        Text("LKR \(amount)")
                    } else if let units = transaction.noOfUnits, !units.isEmpty {
                        Text("Units \(units)")
                    } else {
                        EmptyView()
                    }
                }

                
                Text(transaction.transactionDate?.formattedDateString() ?? "-")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
        .layoutPriority(1)
    }
}

#Preview {
    TransactionRow(transaction: dummyTransactionData, tab: 0)
}

extension String {
    func formattedDateString(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ", outputFormat: String = "dd MMM yyyy") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
}

