//
//  AlertViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/26/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AlertViewController: UIViewController {

    @IBOutlet weak var waitingForRequest: UIActivityIndicatorView!
    
    var selectedRef: FIRDatabaseReference = FIRDatabase.database().reference().child(keys).child("selected")
    var wordToGuessRef: FIRDatabaseReference = FIRDatabase.database().reference().child(keys).child("wordToGuess")
    
    var requestAccepted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitingForRequest.startAnimating()
        
        selectedRef.observe(FIRDataEventType.value, with: { (snapshot) in
            if !snapshot.exists()
            {
                print("Data snapshot doesn't exist...")
                return
            }
                
            else
            {
                let decision = snapshot.value as! Bool
                if (decision)
                {
                    
                    self.observeWordToGuessRef()
                    
                    if(self.requestAccepted){
                        print("Match Complete")
                        self.performSegue(withIdentifier: "toMatch", sender: Any?.self)
                        self.selectedRef.child(keys).removeValue()
                    }
                    else{
                        print("No matches... Yet")
                    }
                    
                }
                else
                {
                    print("No Matches... Yet")
                }
                
            }
            
        })
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAlertButton(match: String) {
        
        // create the alert
        let alert = UIAlertController(title: "UIAlertController", message: "\(match) challenged you. Accept the request?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            
            self.requestAccepted = true
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { action in
            
            self.requestAccepted = false
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func observeWordToGuessRef(){
        
        self.wordToGuessRef.observe(FIRDataEventType.value, with:  { (snapshot) in
            
            let wordToGuess = snapshot.value as! String
            self.createAlertButton(match: wordToGuess)
            
        })
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
