//
//  RxSwift.swift
//  VIPER-Swift5-iOS9-CocoaPods-RxSwift4-XCode11
//
//  Created by user164900 on 3/19/20.
//  Copyright © 2020 user164900. All rights reserved.
//

// credits from www.netguru.com/codestories/networking-with-rxswift

import Foundation
import RxCocoa
import RxSwift

class REST:NSObject {
    //var myEntity = Entity()
    var sampleData:Data!
    
    func loadMySQL<T: Codable>()-> Observable<T>{
        return Observable<T>.create {
            myObserver in
            
            //let observerSample = "RxSwift Reactive Extensions in Swift for iOS"
            
            let url = URL(fileURLWithPath: "https://javarestjson.herokuapp.com/api/produtos")
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                do {
                    
                }
                
            }
            task.resume()
            
            return Disposables.create {
                
            }
        }
        
    }
    
    let obser = Observable.from(["", "", ""]).subscribe(onNext: {(el)->Void in print(el)}, onError: {(err)->Void in print(err)}, onCompleted: {()->Void in }, onDisposed: {()->Void in})
        
}
