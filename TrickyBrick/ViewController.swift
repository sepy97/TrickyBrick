//
//  ViewController.swift
//  hseGame
//
//  Created by Семен Пьянков on 07.07.17.
//  Copyright © 2017 sepy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonGame: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        welcomeLabel.layer.cornerRadius = 10
        welcomeLabel.layer.borderWidth = 0.5
        welcomeLabel.layer.borderColor = UIColor.black.cgColor
        welcomeLabel.layer.masksToBounds = true
        buttonGame.layer.cornerRadius = 5
        buttonGame.layer.borderWidth = 0.5
        buttonGame.layer.borderColor = UIColor.black.cgColor
        buttonGame.layer.masksToBounds = true
    }

    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear (animated)
    }
    
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear (animated)
    }
    
    override func viewWillDisappear (_ animated: Bool) {
        super.viewWillDisappear (animated)
    }
    
    override func viewDidDisappear (_ animated: Bool) {
        super.viewDidDisappear (animated)
    }
    
    @IBAction func tapNewGame (_ sender: Any) {
        buttonGame.setTitle ("New game", for: .normal)
    }


}

