import Foundation

struct TransactionsResponse: Hashable, Codable, Identifiable {
    let id = UUID()
    let status: String
    let openingBalance: String?
    let balance: String?
    let transactions: Transactions
    let pendingTransactions: Transactions
    
    enum CodingKeys: String, CodingKey {
        case status
        case openingBalance = "opening_balance"
        case balance
        case transactions
        case pendingTransactions = "pending_transactions"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = container.decodeString(forKey: .status)
        openingBalance = container.decodeString(forKey: .openingBalance)
        balance = container.decodeString(forKey: .balance)
        transactions = try container.decode(Transactions.self, forKey: .transactions)
        pendingTransactions = try container.decode(Transactions.self, forKey: .pendingTransactions)
    }
}


struct Transactions: Hashable, Codable, Identifiable {
    let id = UUID()
    let data: [TransactionModel]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([TransactionModel].self, forKey: .data) ?? []
    }
}


struct TransactionModel: Hashable, Codable, Identifiable {
    let id = UUID()
    let transactionDate: String?
    let fundName: String?
    let amount: String?
    let noOfUnits: String?
    let status: String?
    let name: String?
    let sqNo: String?
    let transNo: String?
    let accountNo: String?
    let transactedUnits: String?
    let offerBidPrice: String?
    let amountApplied: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionDate = "TRANSACTION_DATE"
        case fundName = "FUND_NAME"
        case amount = "AMOUNT"
        case noOfUnits = "NO_OF_UNITS"
        case status = "status"
        case name = "NAME"
        case sqNo = "SQ_NO"
        case transNo = "TRANS_NO"
        case accountNo = "ACCOUNT_NO"
        case transactedUnits = "TransactedUnits"
        case offerBidPrice = "OFFER_BID_PRICE"
        case amountApplied = "AMOUNT_APPLIED"
    }
    
    init(
        transactionDate: String?,
        fundName: String?,
        amount: String?,
        noOfUnits: String?,
        status: String?,
        name: String?,
        sqNo: String?,
        transNo: String?,
        accountNo: String?,
        transactedUnits: String?,
        offerBidPrice: String?,
        amountApplied: String?
    ) {
        self.transactionDate = transactionDate
        self.fundName = fundName
        self.amount = amount
        self.noOfUnits = noOfUnits
        self.status = status
        self.name = name
        self.sqNo = sqNo
        self.transNo = transNo
        self.accountNo = accountNo
        self.transactedUnits = transactedUnits
        self.offerBidPrice = offerBidPrice
        self.amountApplied = amountApplied
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        transactionDate = container.decodeString(forKey: .transactionDate)
        fundName = container.decodeString(forKey: .fundName)
        amount = container.decodeString(forKey: .amount)
        noOfUnits = container.decodeString(forKey: .noOfUnits)
        status = container.decodeString(forKey: .status)
        name = container.decodeString(forKey: .name)
        sqNo = container.decodeString(forKey: .sqNo)
        transNo = container.decodeString(forKey: .transNo)
        accountNo = container.decodeString(forKey: .accountNo)
        transactedUnits = container.decodeString(forKey: .transactedUnits)
        offerBidPrice = container.decodeString(forKey: .offerBidPrice, decimalPlaces: 6)
        amountApplied = container.decodeString(forKey: .amountApplied)
    }
}

var dummyTransactionData = TransactionModel(
    transactionDate: "2025-05-21T06:45:43.000000Z",
    fundName: "Senfin Growth Fund",
    amount: "3000.00",
    noOfUnits: nil,
    status: "0",
    name: "Subscription",
    sqNo: "-1",
    transNo: "122",
    accountNo: "0015602792121001",
    transactedUnits: "-43.30",
    offerBidPrice: "23.142400",
    amountApplied: "1002.07"
)

