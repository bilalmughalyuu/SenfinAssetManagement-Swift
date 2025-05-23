import Foundation

struct FundsModel: Hashable, Codable, Identifiable {
    var id: String { status }
    let status: String
    let data: [Datum]
}

struct Datum: Hashable, Codable, Identifiable {
    var id: String { fundCode }
    let fundCode: String
    let fundName: String
    let priceDate: String
    let creationPrice: String
    let redimPrice: String
    let type: String
    let color: String
    let accounts: [Account]
    
    enum CodingKeys: String, CodingKey {
        case fundCode = "FUND_CODE"
        case fundName = "FUND_NAME"
        case priceDate = "PRICE_DATE"
        case creationPrice = "CREATION_PRICE"
        case redimPrice = "REDIM_PRICE"
        case type = "TYPE"
        case color = "COLOR"
        case accounts = "ACCOUNTS"
    }
    
    init(fundCode: String, fundName: String, priceDate: String, creationPrice: String, redimPrice: String, type: String, color: String, accounts: [Account]) {
        self.fundCode = fundCode
        self.fundName = fundName
        self.priceDate = priceDate
        self.creationPrice = creationPrice
        self.redimPrice = redimPrice
        self.type = type
        self.color = color
        self.accounts = accounts
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        fundCode = container.decodeString(forKey: .fundCode)
        fundName = container.decodeString(forKey: .fundName)
        priceDate = container.decodeString(forKey: .priceDate)
        color = container.decodeString(forKey: .color)
        creationPrice = container.decodeString(forKey: .creationPrice, decimalPlaces: 6)
        redimPrice = container.decodeString(forKey: .redimPrice, decimalPlaces: 6)
        type = container.decodeString(forKey: .type, decimalPlaces: 6)
        accounts = try container.decodeIfPresent([Account].self, forKey: .accounts) ?? []
    }
}

struct Account: Hashable, Codable, Identifiable {
    var id: String { accountNo }
    let accountNo: String
    let blockNoOfUnit: String
    let pendingNoOfUnit: String
    let noOfUnits: String
    let transactionUnits: String
    let redimPrice: String
    let marketValue: String
    let name: String
    let cost: String
    
    init(accountNo: String, blockNoOfUnit: String, pendingNoOfUnit: String, noOfUnits: String, transactionUnits: String, redimPrice: String, marketValue: String, name: String?, cost: String) {
        self.accountNo = accountNo
        self.blockNoOfUnit = blockNoOfUnit
        self.pendingNoOfUnit = pendingNoOfUnit
        self.noOfUnits = noOfUnits
        self.transactionUnits = transactionUnits
        self.redimPrice = redimPrice
        self.marketValue = marketValue
        self.name = name ?? ""
        self.cost = cost
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        accountNo = container.decodeString(forKey: .accountNo)
        name = container.decodeString(forKey: .name)
        blockNoOfUnit = container.decodeString(forKey: .blockNoOfUnit)
        pendingNoOfUnit = container.decodeString(forKey: .pendingNoOfUnit)
        noOfUnits = container.decodeString(forKey: .noOfUnits)
        transactionUnits = container.decodeString(forKey: .transactionUnits)
        redimPrice = container.decodeString(forKey: .redimPrice, decimalPlaces: 6)
        marketValue = container.decodeString(forKey: .marketValue)
        cost = container.decodeString(forKey: .cost)
    }
    
    enum CodingKeys: String, CodingKey {
        case accountNo = "ACCOUNT_NO"
        case blockNoOfUnit = "BLOCK_NO_OF_UNIT"
        case pendingNoOfUnit = "PENDING_NO_OF_UNIT"
        case noOfUnits = "NO_OF_UNITS"
        case transactionUnits = "TRANSACTION_UNITS"
        case redimPrice = "REDIM_PRICE"
        case marketValue = "MARKET_VALUE"
        case name = "NAME"
        case cost = "COST"
    }
}

var dummyData: Datum = Datum(
    fundCode: "10",
    fundName: "Senfin Growth Fund",
    priceDate: "2024-09-05",
    creationPrice: "14.370000",
    redimPrice: "13.960000",
    type: "2",
    color: "#B40431",
    accounts: [
        Account(
            accountNo: "0015602792121001",
            blockNoOfUnit: "0.00",
            pendingNoOfUnit: "0.00",
            noOfUnits: "189.50",
            transactionUnits: "189.50",
            redimPrice: "13.96",
            marketValue: "2645.42",
            name: nil,
            cost: "1500.00"
        )
    ]
)

extension KeyedDecodingContainer {
    func decodeString(forKey key: KeyedDecodingContainer.Key, decimalPlaces: Int = 2) -> String {
        if let stringValue = try? decodeIfPresent(String.self, forKey: key) {
            return stringValue
        } else if let doubleValue = try? decodeIfPresent(Double.self, forKey: key) {
            return String(format: "%.\(decimalPlaces)f", doubleValue)
        } else if let intValue = try? decodeIfPresent(Int.self, forKey: key) {
            return String(format: "%.\(decimalPlaces)f", Double(intValue))
        } else {
            print("⚠️ Missing or invalid value for key: \(key.stringValue)")
            return ""
        }
    }
}
