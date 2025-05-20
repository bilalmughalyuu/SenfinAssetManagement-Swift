import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var userModel: UserModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isError: Bool = false

    func loginUser(email: String, password: String) async -> UserModel? {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "\(baseUrl)api/login") else {
            errorMessage = "Invalid URL"
            isLoading = false
            isError = true
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONEncoder().encode(body)

            let (data, _) = try await URLSession.shared.data(for: request)

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }

            let user = try JSONDecoder().decode(UserModel.self, from: data)
            self.userModel = user
            isLoading = false
            isError = false
            return user

        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("Error: \(error.localizedDescription)")
            isError = true
            return nil
        }
    }
}
