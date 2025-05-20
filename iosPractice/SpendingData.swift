import Foundation

struct Spending: Identifiable, Codable {
    let id: Int
    let category: String
    let amount: Double
    let date: String
    let note: String
}

let spendingList: [Spending] = [
    Spending(id: 1, category: "Groceries", amount: 45.90, date: "2025-05-13", note: "Weekly grocery shopping"),
    Spending(id: 2, category: "Transport", amount: 12.50, date: "2025-05-12", note: "Bus fare"),
    Spending(id: 3, category: "Dining", amount: 30.00, date: "2025-05-11", note: "Dinner with friends"),
    Spending(id: 4, category: "Utilities", amount: 75.25, date: "2025-05-10", note: "Electricity bill"),
    Spending(id: 5, category: "Entertainment", amount: 20.00, date: "2025-05-09", note: "Movie ticket"),
    Spending(id: 5, category: "Entertainment", amount: 20.00, date: "2025-05-09", note: "Movie ticket"),
    Spending(id: 5, category: "Entertainment", amount: 20.00, date: "2025-05-09", note: "Movie ticket"),
    Spending(id: 5, category: "Entertainment", amount: 20.00, date: "2025-05-09", note: "Movie ticket"),
    Spending(id: 5, category: "Entertainment", amount: 20.00, date: "2025-05-09", note: "Movie ticket")
]
