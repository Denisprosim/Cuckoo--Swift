//
//  ViewController.swift
//  Cuckcoo
//
//  Created by Denis Mišura on 27/12/2018.
//  Copyright © 2018 Denis Mišura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var signBtn: UIButton!
    
    var viewController:ViewController?
    var emailPassed:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
        emailTextField.text = emailPassed
        configureTextField()
        configureTapGesture()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Log Out"
        navigationItem.backBarButtonItem = backItem
    }
    

    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap() {
        print("handle tap called")
        view.endEditing(true)
    }
    
    private func configureTextField() {
        emailTextField.delegate = self
        pwdTextField.delegate = self
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailTextField.text;
        let password = pwdTextField.text;
        

        if(email?.isEmpty)! ||
            (password?.isEmpty)!
        {
            displayMyAlertMessage(userMessage: "Please login")
            return;
        }
        
        if(!isValidEmail(testStr: (email)!)){
            displayMyAlertMessage(userMessage: "Incorrect email")
            
        }
        
        print("Login tapped")
        
        

        
        /*
         //Activity indicator
         let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
         myActivityIndicator.center = view.center
         myActivityIndicator.hidesWhenStopped = true
         myActivityIndicator.startAnimating()
         view.addSubview(myActivityIndicator)
         
         //Start Activity Indicator
         myActivityIndicator.startAnimating()
         view.addSubview(myActivityIndicator)
         
        //Send request
        let myUrl = URL(string: "htttp://localhost:65490/")
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["LoginName": email!,"Password": password! ,"DeviceName": "SwiftApp"] as [String:String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMyAlertMessage(userMessage: "Something went wrong")
            return
        }
         
        let task = URLSession.shared.dataTask(with: request) { (data: Data?,response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMyAlertMessage(userMessage: "Could not perform this task")
                print("error")
                return
            }
            
            //Converting response from a server side code
            do {
                let json = try JSONSerialization.jsonObject(with: Data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    //Accessing with value of Email
                    let accessToken = parseJSON["token"] as? String
                    let userId = parseJSON["id"] as? String
                    
                    if (accessToken?.isEmpty)!
                    {
                        self.displayMyAlertMessage(userMessage: "Could not succesfully perform this request. Please try again later.")
                        return
                    }
                    
                    DispatchQueue.main.async {
         //Redirect to homepage
                        let homePage =
                            self.storyboard?.instantiateInitialViewController(withIdentifier: "FriendListViewController") as! FriendListViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homePage
                    }
                }
            }
            } as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void
        */
        

        //funkcni
        let params = ["LoginName": email!,"Password": password! ,"DeviceName": "SwiftApp"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://palmgrouprestapiserver-fl5.conveyor.cloud/login/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                
                self.displayMyAlertMessage(userMessage: "Could not succesfully perform this request. Please try again later.")
            }
        })
        task.resume()
        
        
        
        if(isValidEmail(testStr: (email)!)){
            performSegue(withIdentifier: "Login", sender: nil)
        }
 
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func displayMyAlertMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default)
                { (action:UIAlertAction!) in
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            return
                    }
                    
                }
                
                
                alertController.addAction(okAction);
                
                self.present(alertController, animated: true, completion: nil);
        }
    }
    
    
    

}

extension ViewController: UITextFieldDelegate {
    
}
