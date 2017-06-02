//
//  InitialViewController.swift
//  CS_M117
//
//  Created by Ryan Stenberg on 5/22/17.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, StreamDelegate {
    
    var inputStream: InputStream?
    var outputStream: OutputStream?
    
    let addr = "192.168.0.17"
    let port = 7001
    
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
    
    // Establish in/out stream with RPi
    func initNetworkCommunication() {
        Stream.getStreamsToHost(withName: addr, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        inputStream?.delegate = self
        outputStream?.delegate = self
        
        inputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        outputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)

        inputStream?.open()
        outputStream?.open()
    }
    
    func startGame() {
        initNetworkCommunication()
        let gameViewController = GameViewController(initialViewController: self)
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    func sendMessage(message: String)   {
        let data = message.data(using: String.Encoding.utf8)!
        let _ = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
