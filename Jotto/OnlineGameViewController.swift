//
//  GameScreenViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/26/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OnlineGameViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    

    var playingOnlineRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Playing Online")
    let letterArray = ["A", "B", "C", "D", "E", "F","G","H","I","J","K","L","M","N","O","P","Q","R", "S", "T","U","V","W","X","Y","Z"]
    
    var countGuessed: Int = 0
    var countCorrectLetters: Int = 0
    
    @IBOutlet weak var playingAgainstLabel: UILabel!
    
    @IBOutlet weak var lettersCollection: UICollectionView!
    
    @IBOutlet weak var wordsGuessedTableView: UITableView!
    
    @IBOutlet weak var guessButton: UIButton!
    
    var ArrayOfGuesses = [String]()
    var ArrayOfCorrectLetters = [Int]()
    var startingFirst: Bool = false
    var isYourTurn: Bool = false

    
    //Text Field for each letter, copied and pasted from first VC
    @IBOutlet weak var letter1: UITextField!
    @IBAction func letter1button(_ sender: AnyObject) {
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[0] = letter1.text!.uppercased()
        yourWord.isHidden = false
        yourWord.text = "\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        letter2.becomeFirstResponder()
    }
    
    @IBOutlet weak var letter2: UITextField!
    @IBAction func letter2button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[1] = letter2.text!.uppercased()
        yourWord.isHidden = false
        yourWord.text = "\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        letter3.becomeFirstResponder()
    }
    
    @IBOutlet weak var letter3: UITextField!
    @IBAction func letter3button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[2] = letter3.text!.uppercased()
        yourWord.isHidden = false
        yourWord.text = "\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        letter4.becomeFirstResponder()
    }
    
    @IBOutlet weak var letter4: UITextField!
    @IBAction func letter4button(_ sender: AnyObject) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[3] = letter4.text!.uppercased()
        yourWord.isHidden = false
        yourWord.text = "\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        letter5.becomeFirstResponder()
        
    }
    
    @IBOutlet weak var letter5: UITextField!
    @IBAction func letter5button(_ sender: AnyObject) {
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        LetterString[4] = letter5.text!.uppercased()
        yourWord.isHidden = false
        yourWord.text = "\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])"
        letter5.resignFirstResponder()
    }
    
    @IBOutlet weak var yourWord: UILabel!
    
    var LetterString = ["_","_","_","_","_"]
    var copyOfLetterString = ["","","","",""]
    let limitLength = 1
    
    //********************************************************
    //VIEW DID LOAD
    //********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(!startingFirst){
            hideAllViewsAndFields()
        }
        
        else{
            lettersCollection.isHidden = false
            wordsGuessedTableView.isHidden = false
            letter1.isHidden = false
            letter2.isHidden = false
            letter3.isHidden = false
            letter4.isHidden = false
            letter5.isHidden = false
        letter1.delegate = self
        letter2.delegate = self
        letter3.delegate = self
        letter4.delegate = self
        letter5.delegate = self
        lettersCollection.delegate = self
        lettersCollection.dataSource = self
        wordsGuessedTableView.delegate = self
        wordsGuessedTableView.dataSource = self
        playingAgainstLabel.text = "Playing against:"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***********************************/
    //Collection View Functions
    /***********************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 26
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = lettersCollection.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! LetterCollectionViewCell
        
        var index = indexPath[1]
        
        cell.letterLabel?.text = letterArray[index]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = lettersCollection.cellForItem(at: indexPath) as! LetterCollectionViewCell
        
        cell.hasBeenSelected += 1
        
        if(cell.hasBeenSelected % 3 == 1){
            
            cell.backgroundColor = UIColor.red
        }
        if(cell.hasBeenSelected % 3 == 2){
            
            cell.backgroundColor = UIColor.green
        }
        if(cell.hasBeenSelected % 3 == 0){
            
            cell.backgroundColor = UIColor.white
        }
    }
    
    
    /***********************************/
    //Table View Functions
    /***********************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countGuessed
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = wordsGuessedTableView.dequeueReusableCell(withIdentifier: "defaultTableViewCell", for: indexPath) as! WordsGuessedTableViewCell
        
        cell.wordGuessedLabel.text = "\(ArrayOfGuesses[indexPath.row].uppercased())"
        
        cell.lettersCorrectLabel.text = "\(ArrayOfCorrectLetters[indexPath.row])"
        
        return cell
        
    }
    
    //Button Function
    
    @IBAction func guessButtonPressed(_ sender: Any) {
        
        self.countCorrectLetters = 0
        
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
            self.countGuessed += 1
            
            for index in 0...4{
                copyOfLetterString[index] = LetterString[index]
            }
            
            for index in 0...4{
                for index1 in 0...4{
                    if(index != index1 && copyOfLetterString[index1] == copyOfLetterString[index])
                    {
                        copyOfLetterString[index] = " "
                    }
                }
            }
            
            for index in 0...4{
                for index2 in 0...4{
                    
                    print(String(wordToGuess[index]))
                    
                    if(String(wordToGuess[index]) == copyOfLetterString[index2]){
                        self.countCorrectLetters += 1
                    }
                }
                
            }
            createAlertButton(numberOfLettersCorrect: countCorrectLetters)
            letter1.text = ""
            letter2.text = ""
            letter3.text = ""
            letter4.text = ""
            letter5.text = ""
            ArrayOfGuesses.append("\(LetterString[0])\(LetterString[1])\(LetterString[2])\(LetterString[3])\(LetterString[4])")
            ArrayOfCorrectLetters.append(countCorrectLetters)
            wordsGuessedTableView.reloadData()
//            let indexPath = IndexPath(item: countGuessed, section: countGuessed)
//            wordsGuessedTableView.reloadRows(at: [indexPath], with: .top)
            yourWord.text = "_ _ _ _ _"
        }

    }

    
    /***********************************/
    //Helper Functions
    /***********************************/
    
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
    
    func hideAllViewsAndFields(){
        lettersCollection.isHidden = true
        wordsGuessedTableView.isHidden = true
        letter1.isHidden = true
        letter2.isHidden = true
        letter3.isHidden = true
        letter4.isHidden = true
        letter5.isHidden = true
    }
    
    
    /**********************************************/
    //Alert Function to show number of correct letters
    /**********************************************/
    func createAlertButton(numberOfLettersCorrect: Int) {
        
        // create the alert
        let alert = UIAlertController(title: "Number Correct:", message: "\(numberOfLettersCorrect) letters in your guess are in your opponent's word", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    

}
