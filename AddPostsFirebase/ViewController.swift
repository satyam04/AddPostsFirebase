//
//  ViewController.swift
//  AddPostsFirebase
//
//  Created by Satyam Saluja on 14/09/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var posts=[post]()
    
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        myTableView.dataSource=self
        super.viewDidLoad()
        //now bringing bcak the data form the firebase :-
        let activityIndicator=UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.color=UIColor.yellow
        
        
        FirebaseServices.shared.postRef.observe(DataEventType.value, with: {(snapshot) in
            print(snapshot)
            activityIndicator.startAnimating()
            
            guard let postsSnap = PostSnapshot(with: snapshot) else {return}
              self.posts=postsSnap.Posts
            self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.myTableView.reloadData()
        })
        activityIndicator.stopAnimating()

    }   

    @IBAction func clickedAdd(_ sender: Any) {
        let alert=UIAlertController(title: "Post something", message: "What would you like to post?", preferredStyle: .alert)
            alert.addTextField{ textfeild in
            textfeild.placeholder="Enter the message"
        }
        let cancel=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let post=UIAlertAction(title: "Post", style: .default) { _ in
            guard let text=alert.textFields?.first?.text else{return}
            print(text)
            
            let DateString=String(describing: Date())
            
            let parameters = ["username":"Satyam04",
                              "message" : text,
                              "date"    : DateString,
                              "details" :  nil      ]
            
            FirebaseServices.shared.postRef.childByAutoId().setValue(parameters)
            


        }
        alert.addAction(cancel)
        alert.addAction(post)
        present( alert, animated: true,completion: nil)
          }
}
    // extension..adding the UITableView-
    extension ViewController: UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell=UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text=posts[indexPath.row].message.capitalized
            cell.detailTextLabel?.text=posts[indexPath.row].username
            return cell
        }
        
    }


