import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ibRomanticComedyView: UIView!
    @IBOutlet weak var ibTvShowsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTapGesture()
    }
    func setUpTapGesture(){
        let romanticTapGesture = UITapGestureRecognizer(target: self, action: #selector(romanticViewTapped(sender: )))
        ibRomanticComedyView.isUserInteractionEnabled = true
        ibRomanticComedyView.addGestureRecognizer(romanticTapGesture)
        
        let tvShowsTapGesture = UITapGestureRecognizer(target: self, action: #selector(tvShowViewTapped(sender: )))
        ibTvShowsView.isUserInteractionEnabled = true
        ibTvShowsView.addGestureRecognizer(tvShowsTapGesture)
    }
    @objc func romanticViewTapped(sender : UITapGestureRecognizer){
        let vc = RomanticComedyVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tvShowViewTapped(sender : UITapGestureRecognizer){
        self.showAlertWith(title: "Coming Soon", message: "This feature is currently under development.")
    }
}

