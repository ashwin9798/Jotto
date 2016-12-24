//
//  ViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/24/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

var keys = ""

class ViewController: UIViewController, UITextFieldDelegate {

    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    @IBOutlet weak var playVsCPUButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    //Text Field for each letter
    @IBOutlet weak var letter1: UITextField!
    @IBAction func letter1button(_ sender: AnyObject) {
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[0] = letter1.text!
        yourWord.isHidden = false
        yourWord.text = "your word: \(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
    }
    
    @IBOutlet weak var letter2: UITextField!
    @IBAction func letter2button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[1] = letter2.text!
        yourWord.isHidden = false
        yourWord.text = "your word: \(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
    }
    
    @IBOutlet weak var letter3: UITextField!
    @IBAction func letter3button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[2] = letter3.text!
        yourWord.isHidden = false
        yourWord.text = "your word: \(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
    }
    
    @IBOutlet weak var letter4: UITextField!
    @IBAction func letter4button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[3] = letter4.text!
        yourWord.isHidden = false
        yourWord.text = "your word: \(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        
    }
    
    @IBOutlet weak var letter5: UITextField!
    @IBAction func letter5button(_ sender: AnyObject) {
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[4] = letter5.text!
        yourWord.isHidden = false
        yourWord.text = "your word: \(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
    }
    
    @IBOutlet weak var yourWord: UILabel!
    
    var LetterString = ["_","_","_","_","_"]
    let limitLength = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        ref = FIRDatabase.database().reference()
        letter1.delegate = self
        letter2.delegate = self
        letter3.delegate = self
        letter4.delegate = self
        letter5.delegate = self
        
        self.yourWord.isHidden = true
        
         self.howToPlayButton.alpha = 0
         self.multiplayerButton.alpha = 0
         self.playVsCPUButton.alpha = 0
         
         UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.howToPlayButton.alpha = 1
         })
         
         UIView.animate(withDuration: 0.5, delay: 0.6, animations: {
            self.multiplayerButton.alpha = 1
         })
         
         UIView.animate(withDuration: 0.5, delay: 1, animations: {
            self.playVsCPUButton.alpha = 1
         })
        
        
        
    }
    
    @IBAction func multiplayerButtonPressed(_ sender: AnyObject) {
        
        if (letter1.text?.isEmpty)!{
            self.yourWord.isHidden = false
            self.yourWord.text = "You missed a letter!"
        }
        else if (letter2.text?.isEmpty)!{
            self.yourWord.isHidden = false
            self.yourWord.text = "You missed a letter!"
        }
        else if (letter3.text?.isEmpty)!{
            self.yourWord.isHidden = false
            self.yourWord.text = "You missed a letter!"
        }
        else if (letter4.text?.isEmpty)!{
            self.yourWord.isHidden = false
            self.yourWord.text = "You missed a letter!"
        }
        else if (letter5.text?.isEmpty)!{
            self.yourWord.isHidden = false
            self.yourWord.text = "You missed a letter!"
        }
        else{
            keys = ref.childByAutoId().key
            let user = userObject(key: keys, name: nameTextField.text!, word: yourWord.text!, selected: false)
            let childUpdates = ["\(keys)" : user.getSnapshotValue()]
            ref.updateChildValues(childUpdates)
            performSegue(withIdentifier: "firstSegue", sender: Any?.self)
        }
        
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        
        if(textField.text!.characters.count > maxLength){
            textField.deleteBackward()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letter1.resignFirstResponder()
        letter2.resignFirstResponder()
        letter3.resignFirstResponder()
        letter4.resignFirstResponder()
        letter5.resignFirstResponder()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
