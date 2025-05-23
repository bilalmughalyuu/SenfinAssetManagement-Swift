
import SwiftUI

struct TransactionsScreen: View {
    
    @StateObject private var viewModel = TransactionsViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var tab: Int = 0
    
    @State private var showModal = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack {
                    Text("Redeem Fund")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    Button (action: {
                        withAnimation {
                            showModal = true
                        }
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
            
            CustomModalView(isVisible: $showModal)
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

struct CustomModalView: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isVisible = false
                        }
                    }
                
                VStack() {
                    
                    Text("TRANSACTION REPORT")
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer().frame(height: 24)
                    
                    Text(verbatim: """
                    Disclaimer:- This is a Transaction Report being generated through the ONLINE PORTAL of the web application and not a Verified Statement of the Client's account. For a Statement of your account, please send a 'Statement Request' to Registrar - Senfin Asset Management (Pvt) Ltd. This request can be sent through the ONLINE PORTAL or through an email to sfam.info@senfin.com.
                    """)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().frame(height: 32)

                    HStack{
                        Button("Close") {
                            withAnimation {
                                isVisible = false
                            }
                        }
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background(Color.redColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        
                        Spacer().frame(width: 16)
                        
                        Button("Download") {
                            withAnimation {
                                isVisible = false
                            }
                        }
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .transition(.opacity)
                .animation(.easeInOut, value: isVisible)
                .padding(.horizontal, 24)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

