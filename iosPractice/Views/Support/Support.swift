import SwiftUI

struct Support: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var selectedItem: String = ""
    @State private var supportItemList = [
        "General",
        "Subscription",
        "Redemption",
        "Transfer",
        "Switch",
        "Reinvest",
        "Lock"
    ]
    @State private var description: String = ""
    @State private var selectedFileURL: URL?
    
    @State var isShowing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button (action: {
                    coordinator.pop()
                }){
                    Image("backButton")
                        .resizable()
                        .frame(width: 22, height: 22)
                }
                Spacer().frame(width: 16)
                Text("Support")
                    .font(.system(size: 18, weight: .bold))
            }
            
            Spacer().frame(height: 12)
            
            Text("How we may help you?")
                .font(.system(size: 14))
            
            CustomPicker(title: "Select type of question",selectedItem: $selectedItem, itemLists: $supportItemList)
            
            Spacer().frame(height: 24)
            
            ZStack(alignment: .topLeading) {
                if description.isEmpty {
                    Text("Please type your inquiry")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .allowsHitTesting(false)
                }
                
                TextEditor(text: $description)
                    .frame(height: 150)
                    .padding(4)
                    .background(Color.white.opacity(0.01))
                    .scrollContentBackground(.hidden)
            }
            .frame(height: 150)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            
            Spacer().frame(height: 32)
            
            VStack(alignment: .center) {
                Image(systemName: "paperclip")
                    .resizable()
                    .frame(width: 24, height: 28)
                    .foregroundColor(.black)
                Text("Add attachments")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .onTapGesture {
                isShowing = true
            }
            .fileImporter(isPresented: $isShowing, allowedContentTypes: [.item], allowsMultipleSelection: true, onCompletion: { results in
                
                switch results {
                case .success(let fileurls):
                    
                    for fileurl in fileurls {
                        selectedFileURL = fileurl
                        print(fileurl.path)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            })
            
            Spacer().frame(height: 32)
            
            if let url: URL = selectedFileURL {
                Text("\(url.lastPathComponent)")
                    .underline(true)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture {
                        if let url = selectedFileURL {
                            print("File path: \(url.path)")
                            print("File extension: \(url.pathExtension)")
                            if FileManager.default.fileExists(atPath: url.path) {
                                if url.startAccessingSecurityScopedResource() {
                                    UIApplication.shared.open(url, options: [:], completionHandler: { success in
                                        if success {
                                            print("Opened file successfully")
                                        } else {
                                            print("Failed to open file")
                                        }
                                        url.stopAccessingSecurityScopedResource()
                                    })
                                } else {
                                    print("Could not access security scoped resource")
                                }
                            } else {
                                print("File does not exist at path: \(url.path)")
                            }
                            
                            
                        }
                    }
            }
            
            Spacer().frame(height: 100)
            
            VStack {
                Text("Submit")
                    .foregroundColor(Color.white)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .cornerRadius(12)
            .onTapGesture {
                //                isSubmitted = true
                //                guard !selectedAccount.isEmpty,
                //                      !selectedRedeemType.isEmpty,
                //                      !selectedRedeemMethod.isEmpty else {
                //                    print("Form is not filled")
                //                    return
                //                }
                //                coordinator.push(.redeemSummary)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 24)
        //        .sheet(isPresented: $showDocumentPicker) {
        //            DocumentPicker { url in
        //                selectedFileURL = url
        //            }
        //        }
    }
    
}

//#Preview {
//    Support(selectedFileURL: URL(fileURLWithPath: "/dev/null"))
//        .environmentObject(NavigationCoordinator())
//}
