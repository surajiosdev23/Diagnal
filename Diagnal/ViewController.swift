//
//  ViewController.swift
//  Diagnal
//
//  Created by suraj jadhav on 26/02/24.
//

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

