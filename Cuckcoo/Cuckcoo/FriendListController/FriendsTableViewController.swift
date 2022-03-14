//
//  FriendsTableViewController.swift
//  Cuckcoo
//
//  Created by Denis Mišura on 16/01/2019.
//  Copyright © 2019 Denis Mišura. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    let cellId = "cellId"
    let messages = [
        "last message","last message","last message"
    ]
    let names = [
        "Kristian"
    ]
    let surnames = [
        "Klima"
    ]
    let image = "user-img.png"
    
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView?.rowHeight = 65
        tableView?.backgroundColor = UIColor.darkGray
        fetchContacts()
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationItem.title = "Friends"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    
    private func fetchContacts() {
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let message = self.messages[indexPath.row]
        let name = self.names[indexPath.row]
        let surname = self.surnames[indexPath.row]
        
        cell.backgroundColor = UIColor.darkGray
        
        //cell.imageView?.image = UIImage(named: image)
        cell.imageView?.tintColor = UIColor.white
        cell.imageView?.image = imageWithImage(image: UIImage(named: image)!, scaledToSize: CGSize(width: 40, height: 40))
        cell.textLabel?.text = name + " " + surname
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        cell.detailTextLabel?.text = message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "chatSegue", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
