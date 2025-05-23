
import SwiftUI

struct TransactionsScreen: View {
    
    @StateObject private var viewModel = TransactionsViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var tab: Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Redeem Fund")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Button (action: {
                    
                }){
                    Image("pdf")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color.brightRed)
                }
                
            }
            .padding(.horizontal, 24)
            
            Spacer().frame(height: 24)
            
            HStack {
                Text("Completed")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(tab == 0 ? Color.white : Color.black)
                    .background(tab == 0 ? Color.primaryColor : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        tab = 0
                    }
                Text("Pending")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(tab == 1 ? Color.white : Color.black)
                    .background(tab == 1 ? Color.primaryColor : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        tab = 1
                    }
            }
            .background(
                Color.gray.opacity(0.2)
                .cornerRadius(8)
            )
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            
            Spacer().frame(height: 24)
            
            let transactions = tab == 0
                            ? (viewModel.transactions?.transactions.data ?? [])
                            : (viewModel.transactions?.pendingTransactions.data ?? [])
            
            List(transactions, id: \.self) { item in
                
                TransactionRow(transaction: item, tab: tab)
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
        }
        .task {
            if let token = userViewModel.userModel?.accessToken {
                let _ = await viewModel.fetchTransactions(token: token)
            }
        }
        
    }
}

#Preview {
    TransactionsScreen()
        .environmentObject(UserViewModel())
}
