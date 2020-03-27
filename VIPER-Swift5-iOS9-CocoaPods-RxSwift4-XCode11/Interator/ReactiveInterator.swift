//
//  RestInterator.swift
//  VIPER-Swift5-iOS9-CocoaPods-RxSwift4-XCode11
//
//  Created by user164900 on 3/23/20.
//  Copyright © 2020 user164900. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol reactiveProtocol: class {
    func sample(_ textAlert:String)
}

class ReactiveInterator {
    //var myEntity = Entity()
    var sampleData:Data!
    weak var delegate:reactiveProtocol!
    
    func loadMySQL<T: Codable>()-> Observable<T>{
        return Observable<T>.create {
            myObserver in
            
            //let observerSample = "RxSwift Reactive Extensions in Swift for iOS"
            
            let url = URL(fileURLWithPath: "https://javarestjson.herokuapp.com/api/produtos")
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                do {
                    let rest:T = try JSONDecoder().decode(ReactiveEntity.self, from: data!) as! T
                    let dataString = String(data: data!, encoding: .utf8)
                    
                    self.delegate.sample(dataString!)
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "RxSwift for iOS", message: "Success \(String(describing: dataString))", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                        
                        //self.present(alert, animated: true)
                    //https://stackoverflow.com/questions/49538546/how-to-obtain-a-uialertcontroller-observable-reactivecocoa-or-rxswift
                    }
                    
                    myObserver.onNext(rest)
                } catch let error {
                    myObserver.onError(error)
                }
                
            }
            task.resume()
            
            return Disposables.create {
                
            }
        }
        
    }
    
    let obser = Observable.from(["", "", ""]).subscribe(onNext: {(el)->Void in print(el)}, onError: {(err)->Void in print(err)}, onCompleted: {()->Void in }, onDisposed: {()->Void in})
    
    
        
}

extension ReactiveInterator {
    
}
