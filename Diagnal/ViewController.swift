import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ibRomanticPressed(_ sender: UIButton) {
        let vc = RomanticComedyVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

