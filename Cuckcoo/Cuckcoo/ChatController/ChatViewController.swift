//
//  ChatViewController.swift
//  Cuckcoo
//
//  Created by Denis Mišura on 22/01/2019.
//  Copyright © 2019 Denis Mišura. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
}

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: ChatTableView!
    fileprivate let cellId = "id123"
    @IBOutlet weak var msgField: UITextField!
    
    
    var chatMessages = [
        ChatMessage(text: "Ahoj, jak se máš?", isIncoming: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Messages"
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
        
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                print("size changed")
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }



    @IBAction func sendBtn(_ sender: Any) {
        let msgText = msgField.text
        if(msgText == ""){
            msgField.resignFirstResponder()
            return
        }
        let params = ["ChatRoomId": cellId,"Text": msgText ,"File": "" ,"Device": "SwiftApp","Token":"" ] as! Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://palmgrouprestapiserver-fl5.conveyor.cloud/message/send")!)
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
        
        chatMessages.append(ChatMessage(text: msgText!, isIncoming:false))
        msgField.text = ""
        msgField.resignFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: true)
        print(chatMessages)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!
        ChatMessageCell

        let chatMessage = chatMessages[indexPath.row]
        cell.chatMessage = chatMessage
        
        return cell
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
