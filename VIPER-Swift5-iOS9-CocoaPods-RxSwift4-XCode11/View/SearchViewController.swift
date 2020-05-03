//
//  SearchViewController.swift
//  VIPER-Swift5-iOS9-CocoaPods-RxSwift4-XCode11
//
//  Created by user164900 on 5/1/20.
//  Copyright © 2020 user164900. All rights reserved.
//

import UIKit
import  RxSwift
import RxCocoa

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let search = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    @objc func btnBackHome(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "RxSwift for iOS App"
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(btnBackHome))
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        let back = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(btnBackHome))
        
        let newBackButton = UIBarButtonItem(title: "Back",
                                            style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBackHome))
        navigationItem.leftBarButtonItem = newBackButton
        
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        
        //navigationItem.rightBarButtonItems = [add, play]
        
    }
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
