import Foundation


// MARK: - RomanticComedyModel
struct RomanticComedyModel: Codable {
    let page: Page?
}

// MARK: - Page
struct Page: Codable {
    let title, totalContentItems, pageNum, pageSize: String?
    let contentItems: ContentItems?

    enum CodingKeys: String, CodingKey {
        case title
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case contentItems = "content-items"
    }
}

// MARK: - ContentItems
struct ContentItems: Codable {
    let content: [Content]?
}

// MARK: - Content
struct Content: Codable {
    let name: String?
    let posterImage: String?

    enum CodingKeys: String, CodingKey {
        case name
        case posterImage = "poster-image"
    }
}
