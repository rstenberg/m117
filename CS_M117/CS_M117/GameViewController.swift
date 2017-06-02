//
//  GameViewController.swift
//  CS_M117
//
//  Created by Ryan Stenberg on 5/22/17.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var initialViewController: InitialViewController?
    
    let closeButton = UIButton()
    
    let noteDimension = CGFloat(45)
    let noteTrackBackground = UIView()
    let noteTrack0 = UIView()
    let noteTrack1 = UIView()
    let noteTrack2 = UIView()
    let noteTrack3 = UIView()
    let noteCircle0 = NoteButton(index: 0)
    let noteCircle1 = NoteButton(index: 1)
    let noteCircle2 = NoteButton(index: 2)
    let noteCircle3 = NoteButton(index: 3)
    
    var onScreenNotes: [UIView] = []
    let noteCount = 4
    
    var points = 0
    let pointsLabel = UILabel()
    
    init(initialViewController: InitialViewController) {
        self.initialViewController = initialViewController
        super.init(nibName: "GameViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 51.0 / 255.0, green: 153.0 / 255.0, blue: 1, alpha: 1)
        
        // Setup pointsLabel
        pointsLabel.frame = CGRect(x: 20, y: screenHeight * 2 / 3, width: 100, height: 50)
        pointsLabel.textColor = .white
        pointsLabel.text = String(points)
        pointsLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightRegular)
        self.view.addSubview(pointsLabel)
        
        // Setup noteTrackBackground
        noteTrackBackground.frame = CGRect(x: (screenWidth / 2) - (noteDimension * 4), y: 0, width: noteDimension * 8, height: screenHeight)
        noteTrackBackground.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        self.view.addSubview(noteTrackBackground)
        
        // Setup noteTracks
        setupNoteTracks()
        
        // Setup noteCircles
        setupNoteButtons()
        
        // Setup closeButton
        closeButton.frame = CGRect(x: screenWidth - 46, y: 16, width: 30, height: 30)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Generate Notes
        for i in 0 ..< noteCount {
            let note = UIView()
            note.frame = CGRect(x: 0, y: 0, width: self.noteDimension, height: self.noteDimension)
            switch i {
            case 0:
                note.backgroundColor = .red
            case 1:
                note.backgroundColor = .blue
            case 2:
                note.backgroundColor = .green
            case 3:
                note.backgroundColor = .purple
            default:
                note.backgroundColor = .orange
            }
            note.layer.cornerRadius = self.noteDimension / 2
            self.onScreenNotes.append(note)
        }
        
        fireNoteStream()
        initialViewController?.sendMessage(message: ".")
    }
    
    func fireNoteStream() {
        
        for trackNum in 0 ..< 4 {
            // Send next note down screen
            switch trackNum {
            case 0:
                self.noteTrack0.addSubview(onScreenNotes[0])
                self.noteTrack0.bringSubview(toFront: self.noteCircle0)
                UIView.animate(withDuration: 3.0, delay: 0, options: [.curveLinear, .repeat], animations: {self.onScreenNotes[0].frame.origin.y = screenHeight}, completion: {
                    (finshed: Bool) in
                    self.onScreenNotes[0].frame.origin.y = 0 - self.noteDimension
                })
            case 1:
                self.noteTrack1.addSubview(onScreenNotes[1])
                self.noteTrack1.bringSubview(toFront: self.noteCircle1)
                UIView.animate(withDuration: 2.6, delay: 0.8, options: [.curveLinear, .repeat], animations: {self.onScreenNotes[1].frame.origin.y = screenHeight}, completion: {
                    (finshed: Bool) in
                    self.onScreenNotes[1].frame.origin.y = 0 - self.noteDimension
                })
            case 2:
                self.noteTrack2.addSubview(onScreenNotes[2])
                self.noteTrack2.bringSubview(toFront: self.noteCircle2)
                UIView.animate(withDuration: 2.3, delay: 1.0, options: [.curveLinear, .repeat], animations: {self.onScreenNotes[2].frame.origin.y = screenHeight}, completion: {
                    (finshed: Bool) in
                    self.onScreenNotes[2].frame.origin.y = 0 - self.noteDimension
                })
            case 3:
                self.noteTrack3.addSubview(onScreenNotes[3])
                self.noteTrack3.bringSubview(toFront: self.noteCircle3)
                UIView.animate(withDuration: 2.0, delay: 1.8, options: [.curveLinear, .repeat], animations: {self.onScreenNotes[3].frame.origin.y = screenHeight}, completion: {
                    (finshed: Bool) in
                    self.onScreenNotes[3].frame.origin.y = 0 - self.noteDimension
                })
            default:
                print("Uh-oh")
            }
        }
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
        initialViewController?.sendMessage(message: "~")
        self.dismiss(animated: true, completion: nil)
    }
    
    func attemptNoteHit(noteButton: NoteButton)   {
        if let notePresentationLayer = onScreenNotes[noteButton.index].layer.presentation() {
            let noteCenter = CGPoint(x: (noteDimension / 2), y: notePresentationLayer.frame.origin.y + (noteDimension / 2))
            if noteButton.frame.contains(noteCenter) {
                print("Got HEEEEEM")
                initialViewController?.sendMessage(message: "n")
                points += 1
                pointsLabel.text = String(points)
            }
        }   else    {
            print("Error: could not get presentation layer")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class NoteButton: UIButton {
        let index: Int
        
        init(index: Int) {
            self.index = index
            super.init(frame: .zero)
        }
        
        required init?(coder aDecoder: NSCoder) {
            self.index = -1
            super.init(coder: aDecoder)
        }
    }
}
