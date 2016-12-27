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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingGraphic.startAnimating()
        self.loadingLabel.isHidden = false

        playingOnlineRef.observe(.childAdded, with: {(snapshot) in
            
            let key = snapshot.key
            let user = userObject(snapshot: snapshot)
            
            if (!user.hasBeenChosen() && key != keys){
                let wordToGuess = user.word
                self.playingOnlineRef.child(keys).child("wordToGuess").setValue(wordToGuess)
                self.playingOnlineRef.child(key).child("wordToGuess").setValue(myWord)
                self.performSegue(withIdentifier: "toRandomGame", sender: Any?.self)
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
