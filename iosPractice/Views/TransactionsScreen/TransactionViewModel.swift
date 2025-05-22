import Foundation

@MainActor
class TransactionsViewModel : ObservableObject {
    
    @Published var transactions: TransactionsResponse?
    @Published var isLoading: Bool = false
    
    func fetchTransactions(token: String?) async -> TransactionsResponse? {
        
        guard let token = token, !token.isEmpty else {
            print(">>> No token found")
            isLoading = false
            return nil
        }
        
        isLoading = true
        
        guard let url = URL(string: "\(baseUrl)api/transactions") else {
            isLoading = false
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            
            let decodedData = try JSONDecoder().decode(TransactionsResponse.self, from: data)
            
            self.transactions = decodedData
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

