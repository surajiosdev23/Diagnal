import UIKit

class RomanticComedyVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var ibCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var viewModel = RomanticComedyVM()
    private var searchBar: UISearchBar!
    private let cellIdentifier = "PosterCell"
    private let backButtonImageName = "Back"
    private let searchButtonImageName = "search"
    private var cellHeight: CGFloat = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar
        setupNavigationBar()
        
        // Setup collection view
        setupCollectionView()
        
        // Set up view model
        viewModel.delegate = self
        viewModel.fetchDataFromJSON(page: 1)
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        // Set up back button
        setupBackButton()
        
        // Set up search button
        setupSearchButton()
    }
    
    private func setupBackButton() {
        let backButton = createCustomButton(imageName: backButtonImageName, title: " Romantic Comedy", action: #selector(backAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupSearchButton() {
        let searchButton = createCustomButton(imageName: searchButtonImageName, action: #selector(searchAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func createCustomButton(imageName: String, title: String? = nil, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        return button
    }
    
    private func setupCollectionView() {
        let edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cellHeight = calculateCellHeight(for: ibCollectionView, rowSpacing: 45)
        let flowLayout = setupCollectionViewFlowLayout(withRowHeight: cellHeight, columnCount: 3, itemSpacing: 5, rowSpacing: 45, edgeInsets: edgeInsets)
        ibCollectionView.collectionViewLayout = flowLayout
        ibCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func calculateCellHeight(for collectionView: UICollectionView, rowSpacing: CGFloat) -> CGFloat {
        let availableHeight = collectionView.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        let rows = 3 // Desired number of rows
        let totalRowSpacing = CGFloat(rows - 1) * rowSpacing
        return (availableHeight - totalRowSpacing) / CGFloat(rows)
    }
    
    // MARK: - Actions
    
    @objc private func searchAction() {
        // Handle search button action
        print("Search button tapped")
    }
    
    @objc private func backAction() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension RomanticComedyVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PosterCell else {
            return UICollectionViewCell()
        }
        
        if let contentItem = viewModel.contentItem(at: indexPath.row) {
            let imageName = contentItem.posterImage != nil ? "Slices/\(contentItem.posterImage!)" : "placeholder_for_missing_posters"
            cell.ibImage.image = UIImage(named: imageName) ?? UIImage(named: "placeholder_for_missing_posters")
            cell.ibTitle.text = contentItem.name ?? "-"
        } else {
            cell.ibImage.image = UIImage(named: "placeholder_for_missing_posters")
            cell.ibTitle.text = "-"
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RomanticComedyVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight && viewModel.numberOfItems < viewModel.totalItem {
            viewModel.fetchNextPage()
        }
    }
}

// MARK: - RomanticComedyVMDelegate

extension RomanticComedyVC: RomanticComedyVMDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.ibCollectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        print("Error: \(message)")
        // You can display an alert or other UI component to inform the user about the error.
        self.showAlertWith(title: "Error Occured", message: message)
    }
}
