//
//  RxSwiftViewController.swift
//  VIPER-Swift5-iOS9-CocoaPods-RxSwift4-XCode11
//
//  Created by user164900 on 3/24/20.
//  Copyright © 2020 user164900. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {
    
    @IBOutlet weak var myRxTextView: UITextView!
    
    @IBOutlet weak var labelRx: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //https://stackoverflow.com/questions/45234915/uitextfield-binding-to-viewmodel-with-rxswift/45238861
        
        /*
        myRxTextView.rx.text.asObservable()
            .ifEmpty(default: "my default")
            .bind(onNext: {txt in self.labelRx?.text = txt})
            .disposed(by:disposeBag)
        */
        
        //self.labelRx?.text = "OK"
        
    //https://www.iosapptemplates.com/blog/ios-development/rxswift-reactive-programming-swift
        let observable = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("simple rxSwift testing")
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe(onNext: { (element) in
            print(element)
            DispatchQueue.main.async {
                self.labelRx?.text = element
            }
        }).dispose()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //https://www.netguru.com/codestories/networking-with-rxswift
    func loadMySQL<T: Codable>()-> Observable<T>{
        return Observable<T>.create {
            myObserver in
            
            //let observerSample = "RxSwift Reactive Extensions in Swift for iOS"
            
            let url = URL(fileURLWithPath: "https://javarestjson.herokuapp.com/api/produtos")
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                do {
                    let rest:T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    //let dataString = String(data: data!, encoding: .utf8)
                    myObserver.onNext(rest)
                } catch let error {
                    myObserver.onError(error)
                }
                myObserver.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
    
    let obser = Observable.from(["", "", ""]).subscribe(onNext: {(el)->Void in print(el)}, onError: {(err)->Void in print(err)}, onCompleted: {()->Void in }, onDisposed: {()->Void in})

    @IBAction func btnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}