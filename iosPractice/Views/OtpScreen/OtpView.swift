import SwiftUI

struct OTPScreen: View {
    @State private var otp: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?
    
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                HStack() {
                    Button {
                        coordinator.pop()
                    } label: {
                        Image("backButton")
                    }
                    Spacer().frame(width: 16)
                    Text("OTP")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                }
                
                Spacer().frame(height: 100)
                
                Text("Please enter the One-Time Password to complete your transaction")
                    .font(.system(size: 18, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 20)
                
                Text("A One-Time Password has been sent to jdeo50570@gmail.com")
                    .font(.system(size: 14, weight: .light))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 80)

                HStack(spacing: 10) {
                    ForEach(0..<6, id: \.self) { index in
                        TextField("", text: $otp[index])
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 55)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .focused($focusedIndex, equals: index)
                            .onChange(of: otp[index]) { newValue in
                                if newValue.count == 1 && index < 5 {
                                    focusedIndex = index + 1
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                
                Spacer().frame(height: 80)

                Button(action: {
                    let enteredOTP = otp.joined()
                    print("Entered OTP: \(enteredOTP)")
                }) {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 30)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                focusedIndex = 0
            }
        }
    }
}

#Preview{
    OTPScreen()
}
