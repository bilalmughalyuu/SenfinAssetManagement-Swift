
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
                    Image(systemName: "doc")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color.brightRed)
                }
                
            }
            
            Spacer().frame(height: 24)
            
            HStack {
                Text("Completed")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(tab == 0 ? Color.primaryColor : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        tab = 0
                    }
                Text("Pending")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
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
            
            Spacer().frame(height: 24)
            
            List(viewModel.transactions?.transactions.data ?? [], id: \.accountNo) { item in
                
                VStack{
                    HStack {
                        Text(item.accountNo ?? "")
                        Spacer()
                        Text(item.name ?? "")
                    }
                }
                
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
            .listRowSeparator(.hidden)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .task {
            if let token = userViewModel.userModel?.accessToken {
//                print("Calling fetchfunds with token: \(token)")
                let result = await viewModel.fetchTransactions(token: token)
                print(result)
//                print("Fetch complete: \(result)")
            }
        }
        
    }
}

#Preview {
    TransactionsScreen()
        .environmentObject(TransactionsViewModel())
}
