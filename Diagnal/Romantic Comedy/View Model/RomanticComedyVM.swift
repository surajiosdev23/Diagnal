import Foundation

class RomanticComedyVM {
    
    // MARK: - Properties
    
    weak var delegate: RomanticComedyVMDelegate?
    private var contentItems = [Content]()
    private var currentPage = 1
    private var totalPages = 1 // Default value
    private var isFetchingData = false // Flag to track fetch operation
    var totalItem = 0 // Total items fetched
    
    // Computed property to get the number of items
    var numberOfItems: Int {
        return contentItems.count
    }
    
    // MARK: - Public Methods
    
    // Retrieve content item at a given index
    func contentItem(at index: Int) -> Content? {
        guard index < contentItems.count else {
            return nil
        }
        return contentItems[index]
    }
    
    // Fetch data from JSON for a specific page
    func fetchDataFromJSON(page: Int) {
        // Check if the JSON file exists
        guard let path = Bundle.main.path(forResource: "CONTENTLISTINGPAGE-PAGE\(page)", ofType: "json") else {
            delegate?.showError(message: "JSON file not found.")
            return
        }
        
        // Check if a fetch operation is already in progress
        guard !isFetchingData else {
            return
        }
        isFetchingData = true
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let romanticComedyModel = try decoder.decode(RomanticComedyModel.self, from: data)
            
            // Extract content items from the model
            if let contentItems = romanticComedyModel.page?.contentItems?.content {
                self.contentItems.append(contentsOf: contentItems)
                self.totalPages = Int(romanticComedyModel.page?.totalContentItems ?? "0") ?? 1
                self.currentPage = romanticComedyModel.page?.pageNum.flatMap { Int($0) } ?? 1
                self.totalItem = Int(romanticComedyModel.page?.totalContentItems ?? "0") ?? 0
                delegate?.reloadData()
            } else {
                delegate?.showError(message: "No content found.")
            }
        } catch {
            delegate?.showError(message: "Error reading JSON file: \(error.localizedDescription)")
        }
        
        // Reset the fetch operation flag
        isFetchingData = false
    }
    
    // Fetch the next page
    func fetchNextPage() {
        guard currentPage < totalPages else {
            return // No more pages to fetch
        }
        currentPage += 1
        fetchDataFromJSON(page: currentPage)
    }
}

// MARK: - Protocol

protocol RomanticComedyVMDelegate: AnyObject {
    func reloadData()
    func showError(message: String)
}

