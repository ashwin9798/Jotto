//
//  UserListViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/24/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserListViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var count: Int = 0
    var height: Int = 0
    var ArrayOfUsernames = [String]()
    var ArrayOfKeys = [String]()
    var ArrayOfButtons = [UIButton]()
    var whichButtonDeleted: Int = 0
    var whichButtonEmpty: Int = 0
    var buttonIsEmpty: Bool = false
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.ref.observe(.childAdded, with: {(snapshot) in
            
            let key = snapshot.key
            let user = userObject(snapshot: snapshot)
            let username = user.name as String?
            
            if username != nil {
                
                for index in 0...self.ArrayOfKeys.count-1{
                    if (self.ArrayOfKeys[index] == "0"){
                        self.whichButtonEmpty = index;
                        self.buttonIsEmpty = true
                        self.ArrayOfKeys[index] = user.key
                        self.ArrayOfUsernames[index] = username!
                        break
                    }
                }
                
                if(!self.buttonIsEmpty){
                    self.ArrayOfUsernames.append(username!)
                    self.ArrayOfKeys.append(user.key)
                }

                if (self.whichButtonEmpty != 0){
                
                    self.createButton(yPos: 40 + 115*(self.whichButtonEmpty), username: username!)
                    self.height = (40 + 115*(self.count)) + 50
                    
                }
                else{
                    self.count += 1
                    self.createButton(yPos: 40 + 115*(self.count), username: username!)
                    self.height = (40 + 115*(self.count)) + 50
                }
                
            }
            self.scrollView.contentSize.height = CGFloat(self.height)
            self.whichButtonEmpty = 0
            self.buttonIsEmpty = false

            
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createButton(yPos: Int, username: String){
        
        let button = UIButton(frame: CGRect(x: 16, y: yPos, width: 343, height: 99))
        button.setBackgroundImage(#imageLiteral(resourceName: "Rectangle 4"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        button.setTitle(username, for: UIControlState.normal)
        button.setTitleColor(UIColor.purple, for: UIControlState.normal)
        button.alpha = 0
        
        if(self.buttonIsEmpty == true){
            button.tag = self.whichButtonEmpty
            ArrayOfButtons[self.whichButtonEmpty-1] = button
        }
        else{
            button.tag = self.count
            ArrayOfButtons.append(button)
        }
    }
    
    func buttonAction(sender: UIButton){
        
        let buttonTag: UIButton = sender
        
        for index in 0...self.count{
            
            if((self.ArrayOfUsernames[index] == buttonTag.currentTitle) && buttonTag.tag == index){
                let key = ArrayOfKeys[index]
                
                ref.child(key).child("selected").setValue(true)
                
                ref.child(keys).removeValue()
                
                performSegue(withIdentifier: "toMatch", sender: Any?.self)
            }
        }
        whichButtonDeleted = buttonTag.tag
    }

}
