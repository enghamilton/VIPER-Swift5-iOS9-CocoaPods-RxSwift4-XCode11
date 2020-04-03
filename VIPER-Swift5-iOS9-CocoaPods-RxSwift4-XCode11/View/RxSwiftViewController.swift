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
    
    @IBOutlet weak var labelRx2: UILabel!
    
    
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
            //observer.onNext("simple rxSwift testing")
            
            let url = URL(string: "https://javarestjson.herokuapp.com/api/produtos")!
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                let myTextSample = String(data: data!, encoding: .utf8)
                observer.onNext(myTextSample!)
            }
            task.resume()
            
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe(onNext: { (element) in
            print(element)
            DispatchQueue.main.async {
                self.labelRx?.text = element
                
                let alert = UIAlertController(title: "RxSwift 4 for iOS", message: element, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        }).dispose()
        
        let url = URL(string: "https://javarestjson.herokuapp.com/api/produtos")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            [weak self] (data, response, error) in
            DispatchQueue.main.async {
                let myText = String(data: data!, encoding: .utf8)
                self?.labelRx2.text = myText!
            }
            
        }
        task.resume()
        
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
                [weak self] (data2, response2, error2) in
                do {
                    let rest = try JSONDecoder().decode(T.self, from: data2 ?? Data())
                    
                    DispatchQueue.main.async {
                        self?.labelRx2.text = "hello Rx"
                    }
                    
                    myObserver.onNext(rest)
                } catch let error2 {
                    myObserver.onError(error2)
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
    
    
    @IBAction func reactiveButton(_ sender: Any) {
        
    }
    
}
