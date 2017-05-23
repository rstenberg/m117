//
//  InitialViewController.swift
//  CS_M117
//
//  Created by Ryan Stenberg on 5/22/17.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 179.0 / 255.0, green: 45.0 / 255.0, blue: 0, alpha: 1.0)
        
        // Setup startButton
        startButton.frame = CGRect(x: UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height / 2 - 25, width: UIScreen.main.bounds.width / 2, height: 50)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        self.view.addSubview(startButton)
    }
    
    func startGame()    {
        let gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
