import Foundation

struct UserModel: Codable, Identifiable {
    var id: String?
    let status: String?
    let accessToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let redirect: String?
    let user: User?
    let advertisement: Advertisement?
    let news: [News]?
    let maintenanceNotification: Int?

    enum CodingKeys: String, CodingKey {
        case status
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case redirect
        case user
        case advertisement
        case news
        case maintenanceNotification = "maintenance_notification"
    }
}

struct Advertisement: Codable {
    let id: Int?
    let head: String?
    let fundCode: String?
    let text: String?
    let value: String?
    let asAt: String?
    let status: Int?
    let userID: Int?
    let createdAt: String?
    let updatedAt: String?
    let fund: Fund?

    enum CodingKeys: String, CodingKey {
        case id, head
        case fundCode = "FUND_CODE"
        case text, value, asAt = "as_at", status
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case fund
    }
}

struct Fund: Codable {
    let fundCode: String?
    let fundName: String?
    let fundManager: String?
    let trustee: String?
    let launchDate: String?
    let fundType: String?
    let ipoStartDate: String?
    let ipoEndDate: String?
    let maturityDate: String?
    let active: String?
    let priceDecimal: String?
    let consHolidays: String?
    let stcode: String?
    let tinNo: String? // Replacing NSNull with optional String

    enum CodingKeys: String, CodingKey {
        case fundCode = "FUND_CODE"
        case fundName = "FUND_NAME"
        case fundManager = "FUND_MANAGER"
        case trustee = "TRUSTEE"
        case launchDate = "LAUNCH_DATE"
        case fundType = "FUND_TYPE"
        case ipoStartDate = "IPO_START_DATE"
        case ipoEndDate = "IPO_END_DATE"
        case maturityDate = "MATURITY_DATE"
        case active = "ACTIVE"
        case priceDecimal = "PRICE_DECIMAL"
        case consHolidays = "CONS_HOLIDAYS"
        case stcode = "STCODE"
        case tinNo = "TIN_NO"
    }
}

struct News: Codable {
    let text: String?
}

struct User: Codable {
    let name: String?
    let email: String?
    let mobile: String?
    let mobileVerification: String?
    let profile: Int?
    let kyc: Int?
    let application: Int?
    let corporate: Int?
    let image: String? // Replacing NSNull
    let jointUser: String? // Replacing NSNull

    enum CodingKeys: String, CodingKey {
        case name, email, mobile
        case mobileVerification = "mobile_verification"
        case profile, kyc, application, corporate, image
        case jointUser = "joint_user"
    }
}
