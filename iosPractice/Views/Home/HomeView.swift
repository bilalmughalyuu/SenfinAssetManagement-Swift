import SwiftUI
import AlertToast

struct HomeView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var selectedFund: Datum? = nil
    
    @State private var showError: Bool = false
    
    var body: some View {
        let data = viewModel.funds?.data ?? []
        
        VStack{
            VStack(spacing: 8) {
                Spacer().frame(height: 32)
                Image("colorLogo")
                    .resizable()
                    .frame(width: 188, height: 46)
                
                Spacer().frame(height: 16)
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Fixed Income")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#2a6877"))
                        
                        Spacer().frame(height: 4)
                        
                        Text("149,863")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer().frame(width: 16)
                    
                    Rectangle()
                        .frame(width: 1, height: 35)
                        .foregroundColor(Color.black.opacity(0.3))
                    
                    Spacer().frame(width: 16)
                    
                    VStack(alignment: .leading) {
                        Text("Equity")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#2a6877"))
                        
                        Spacer().frame(height: 4)
                        
                        Text("3650.42")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(height: 240)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            .shadow(color: Color.black.opacity(0.16), radius: 20, x: 0, y: 1)
            
            List(data, id: \.fundCode) { item in
                FundRowView(fund: item, showError: $showError)
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
            
        }
        //        if showError {
        //            VStack {
        //                FlushbarView(
        //                    message: "Not enough funds to withdraw!",
        //                    backgroundColor: .red
        //                )
        //                .transition(.move(edge: .top).combined(with: .opacity))
        //                .onAppear {
        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //                        withAnimation {
        //                            showError = false
        //                        }
        //                    }
        //                }
        //                Spacer()
        //            }
        //            .frame(maxHeight: .infinity)
        //        }
        
        .toast(isPresenting: $showError, offsetY: 12) {
            AlertToast(
                displayMode: .hud,
                type: .regular,
                title: "Not enough credit to withdraw",
                style: .style(
                    backgroundColor: Color.redColor,
                    titleColor: .white
                )
            )
        }
        .edgesIgnoringSafeArea(.top)
        .task {
            if let token = userViewModel.userModel?.accessToken {
                let _ = await viewModel.fetchfunds(token: token)
            }
        }
    }
    
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    HomeView()
        .environmentObject(UserViewModel())
        .environmentObject(HomeViewModel())
}
