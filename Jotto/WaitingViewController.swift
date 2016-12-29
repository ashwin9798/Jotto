//
//  WaitingViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/27/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WaitingViewController: UIViewController {
    
    @IBOutlet weak var loadingGraphic: UIActivityIndicatorView!

    @IBOutlet weak var loadingLabel: UILabel!
    
    var playingOnlineRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Playing Online")
    
    var myRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Playing Online").child(keys).child("someoneSetMyValue")
    
    var goingFirst: Bool = true
    
    func checkIfSomeoneSetValue() -> Bool {
        var state = false
        myRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            state = snapshot.value as! Bool
            
        })
        if (state){
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingGraphic.startAnimating()
        self.loadingLabel.isHidden = false

        playingOnlineRef.observe(.childAdded, with: {(snapshot) in
            
            let key = snapshot.key
            let user = userObject(snapshot: snapshot)
            
            if (!user.hasBeenChosen() && key != keys){
                let guessWord = user.word
    
                self.playingOnlineRef.child(keys).child("wordToGuess").setValue(guessWord)
                
                wordToGuess = guessWord
                
                self.playingOnlineRef.child(key).child("wordToGuess").setValue(myWord)
                self.playingOnlineRef.child(key).child("someoneSetMyValue").setValue(true)
                
                self.performSegue(withIdentifier: "toRandomGame", sender: Any?.self)
            }
            
            else if (key == keys){
                
                if(self.checkIfSomeoneSetValue()){
                    self.goingFirst = false
                    self.performSegue(withIdentifier: "toRandomGame", sender: Any?.self)
                }
            }
            
        })
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRandomGame"){
            let OnlineGameData = segue.destination as! OnlineGameViewController
            if(goingFirst){
                OnlineGameData.startingFirst = true
            }
            else{
                OnlineGameData.startingFirst = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
