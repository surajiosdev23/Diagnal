import UIKit

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var ibImage: UIImageView!
    @IBOutlet weak var ibTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ibTitle.font = UIFont(name: "TitilliumWeb-Light", size: 18)
    }
}
