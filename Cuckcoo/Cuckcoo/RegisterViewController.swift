//
//  Register.swift
//  Cuckcoo
//
//  Created by Denis Mišura on 29/12/2018.
//  Copyright © 2018 Denis Mišura. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var cmpwdTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTextField()
        configureTapGesture()
    }
    /*
    override func prepare (for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "btnSignUpSegue") {
            let svc = segue.destination as! ViewController
            svc.emailPassed = emailTextField.text
        }
    }
 */

    
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

    @IBAction func btnSignUp(_ sender: Any) {
        let email = emailTextField.text;
        let name = nameTextField.text;
        let surname = surnameTextField.text;
        let password = pwdTextField.text;
        let confirmpwd = cmpwdTextField.text;
        
        //check for empty fields
        if(name?.isEmpty)! ||
            (email?.isEmpty)! ||
            (surname?.isEmpty)! ||
            (password?.isEmpty)! ||
            (confirmpwd?.isEmpty)!
        {
            displayMyAlertMessage(userMessage: "All field must be filled")
        }
        
        else if(password != confirmpwd)
        {
            displayMyAlertMessage(userMessage: "Passwords do not match")
        }
        
        else if((password?.count)! < 8){
            displayMyAlertMessage(userMessage: "Password must be of minimum 8 characters")
        }
  
        else if(!isValidEmail(testStr: (email)!)){
            displayMyAlertMessage(userMessage: "Incorrect email")
        }
        let params = ["Name": name!,"Surname": surname!,"Email": email!, "ProfilePhoto": "photo", "Day": "1", "Month": "2","Year": "1999","Country": "CZ","DeviceName": "SwiftApp"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://palmgrouprestapiserver-fl5.conveyor.cloud/user/create")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                
                self.displayMyAlertMessage(userMessage: "Could not succesfully perform this request. Please try again later.")
            }
        })
        task.resume()
        
        let params2 = ["Password": password!,"DeviceName": "SwiftApp","Token": "",] as Dictionary<String, String>
        
        var request2 = URLRequest(url: URL(string: "https://palmgrouprestapiserver-fl5.conveyor.cloud/user/create")!)
        request2.httpMethod = "POST"
        request2.httpBody = try? JSONSerialization.data(withJSONObject: params2, options: [])
        request2.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request2, completionHandler: { data, response, error -> Void in
            //print(response!)
            do {
                let json2 = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json2)
            } catch {
                
                self.displayMyAlertMessage(userMessage: "Could not succesfully perform this request. Please try again later.")
            }
        })
        task2.resume()
        
        if(password == confirmpwd)
        {
            performSegue(withIdentifier: "btnSignUpSegue", sender: nil)
        }

        
        /* Redirecting to another view
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         self.present(newViewController, animated: true, completion: nil)
         */
        
        //performSegue(withIdentifier: "btnSignUpSegue", sender: nil)
    
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
                           // self.dismiss(animated: true, completion: nil)
                            return
                    }
                }
                alertController.addAction(okAction);
                self.present(alertController, animated: true, completion: nil);
            }
        }

    
    }

extension RegisterViewController: UITextFieldDelegate {

}


