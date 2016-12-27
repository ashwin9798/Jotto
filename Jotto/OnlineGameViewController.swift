//
//  GameScreenViewController.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/26/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OnlineGameViewController: UIViewController {
    

    var playingOnlineRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Playing Online")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
