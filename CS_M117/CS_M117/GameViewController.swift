//
//  GameViewController.swift
//  CS_M117
//
//  Created by Ryan Stenberg on 5/22/17.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let closeButton = UIButton()
    
    let noteDimension = CGFloat(30)
    let noteTrackBackground = UIView()
    let noteTrack0 = UIView()
    let noteTrack1 = UIView()
    let noteTrack2 = UIView()
    let noteTrack3 = UIView()
    let noteCircle0 = UIButton()
    let noteCircle1 = UIButton()
    let noteCircle2 = UIButton()
    let noteCircle3 = UIButton()
    
    let note = UIView()
    
    // TODO: Create a note queue for each of the 4 tracks
    //       Have the queue delete items as they leave the screen
    //       Add new items to the queue in some random order
    //       Always check if noteButton's frame contains the bottom note in the queue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 51.0 / 255.0, green: 153.0 / 255.0, blue: 1, alpha: 1)
        
        // Setup closeButton
        closeButton.frame = CGRect(x: screenWidth - 46, y: 16, width: 30, height: 30)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        // Setup noteTrackBackground
        noteTrackBackground.frame = CGRect(x: (screenWidth / 2) - (noteDimension * 4), y: 0, width: noteDimension * 8, height: screenHeight)
        noteTrackBackground.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        self.view.addSubview(noteTrackBackground)
        
        // Setup noteTracks
        setupNoteTracks()
        
        // Setup noteCircles
        setupNoteButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup notes
        note.frame = CGRect(x: 0, y: 0, width: noteDimension, height: noteDimension)
        note.backgroundColor = .red
        note.layer.cornerRadius = noteDimension / 2
        noteTrack0.addSubview(note)
        noteTrack0.bringSubview(toFront: noteCircle0)
        UIView.animate(withDuration: 5.0, delay: 0.25, animations: {self.note.frame.origin.y = screenHeight})
    }
    
    func setupNoteTracks() {
        
        noteTrack0.frame.size = CGSize(width: noteDimension, height: screenHeight)
        noteTrack1.frame.size = noteTrack0.frame.size
        noteTrack2.frame.size = noteTrack0.frame.size
        noteTrack3.frame.size = noteTrack0.frame.size
        
        noteTrack0.frame.origin = CGPoint(x: noteDimension / 2, y: 0)
        noteTrack1.frame.origin = CGPoint(x: noteTrack0.frame.maxX + noteDimension, y: 0)
        noteTrack2.frame.origin = CGPoint(x: noteTrack1.frame.maxX + noteDimension, y: 0)
        noteTrack3.frame.origin = CGPoint(x: noteTrack2.frame.maxX + noteDimension, y: 0)
        
        noteTrack0.backgroundColor = .clear
        noteTrack1.backgroundColor = .clear
        noteTrack2.backgroundColor = .clear
        noteTrack3.backgroundColor = .clear
        
        noteTrackBackground.addSubview(noteTrack0)
        noteTrackBackground.addSubview(noteTrack1)
        noteTrackBackground.addSubview(noteTrack2)
        noteTrackBackground.addSubview(noteTrack3)
    }
    
    func setupNoteButtons() {
        
        noteCircle0.frame.size = CGSize(width: noteDimension, height: noteDimension)
        noteCircle1.frame.size = noteCircle0.frame.size
        noteCircle2.frame.size = noteCircle0.frame.size
        noteCircle3.frame.size = noteCircle0.frame.size
        
        let buffer = CGFloat(16)
        noteCircle0.frame.origin = CGPoint(x: 0, y: screenHeight - noteDimension - buffer)
        noteCircle1.frame.origin = CGPoint(x: 0, y: screenHeight - noteDimension - buffer)
        noteCircle2.frame.origin = CGPoint(x: 0, y: screenHeight - noteDimension - buffer)
        noteCircle3.frame.origin = CGPoint(x: 0, y: screenHeight - noteDimension - buffer)
        
        noteCircle0.backgroundColor = .clear
        noteCircle1.backgroundColor = .clear
        noteCircle2.backgroundColor = .clear
        noteCircle3.backgroundColor = .clear
        
        noteCircle0.layer.borderColor = UIColor.white.cgColor
        noteCircle0.layer.borderWidth = 2
        noteCircle0.layer.cornerRadius = noteDimension / 2
        noteCircle1.layer.borderColor = UIColor.white.cgColor
        noteCircle1.layer.borderWidth = 2
        noteCircle1.layer.cornerRadius = noteDimension / 2
        noteCircle2.layer.borderColor = UIColor.white.cgColor
        noteCircle2.layer.borderWidth = 2
        noteCircle2.layer.cornerRadius = noteDimension / 2
        noteCircle3.layer.borderColor = UIColor.white.cgColor
        noteCircle3.layer.borderWidth = 2
        noteCircle3.layer.cornerRadius = noteDimension / 2
        
        noteCircle0.addTarget(self, action: #selector(attemptNoteHit), for: .touchUpInside)
        noteCircle1.addTarget(self, action: #selector(attemptNoteHit), for: .touchUpInside)
        noteCircle2.addTarget(self, action: #selector(attemptNoteHit), for: .touchUpInside)
        noteCircle3.addTarget(self, action: #selector(attemptNoteHit), for: .touchUpInside)
        
        noteTrack0.addSubview(noteCircle0)
        noteTrack1.addSubview(noteCircle1)
        noteTrack2.addSubview(noteCircle2)
        noteTrack3.addSubview(noteCircle3)
    }
    
    func close()    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func attemptNoteHit(button: UIButton)   {
        if let notePresentationLayer = note.layer.presentation() {
            let noteCenter = CGPoint(x: (noteDimension / 2), y: notePresentationLayer.frame.origin.y + (noteDimension / 2))
            if button.frame.contains(noteCenter) {
                print("Got HEEEEEM")
            }
        }   else    {
            print("Error: could not get presentation layer")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
