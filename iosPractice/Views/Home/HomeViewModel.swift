import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var funds: FundsModel?
    @Published var isLoading: Bool = false
    
    
    func fetchfunds(token: String?) async -> FundsModel? {
        guard let token = token, !token.isEmpty else {
            print("Token is missing")
            isLoading = false
            return nil
        }
        
        isLoading = true
        
        guard let url = URL(string: "\(baseUrl)api/accounts") else {
            isLoading = false
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }
            
//            print(data, response)
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
//                isLoading = false
//                return nil
//            }
            
            let decodedData = try JSONDecoder().decode(FundsModel.self, from: data)
            self.funds = decodedData
            self.isLoading = false
            return decodedData
            
        } catch {
            print("Fetch funds error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return nil
        }
    }
}
