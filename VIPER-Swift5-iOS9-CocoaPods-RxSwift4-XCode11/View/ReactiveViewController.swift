//
//  ReactiveViewController.swift
//  VIPER-Swift5-iOS9-CocoaPods-RxSwift4-XCode11
//
//  Created by user164900 on 3/20/20.
//  Copyright © 2020 user164900. All rights reserved.
//

import UIKit

class ReactiveViewController: UIViewController {
        
    var rest = REST()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnBackHome(){
        self.dismiss(animated: true, completion: nil)
    }

}
