//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Mihailo Jovanovic on 13.10.21..
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = self
        self.navigationItem.hidesBackButton = true
        loadMessages()
        
    }
    
    func loadMessages(){
        let collectionRef = db.collection("messages")
        collectionRef.addSnapshotListener({ (querySnapshot, error) in
            self.messages = []
            guard let query = querySnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            if let er = error {
                print(er.localizedDescription)
                return
            }
            guard let data = querySnapshot?.documents else {
              print("Document data was empty.")
              return
            }
            for queryDoc in data{
                if let messageSender = queryDoc.data()["sender"] as? String,let messageBody = queryDoc.data()["text"] as? String,let time = queryDoc.data()["time"] as? String {
                    let addMessage = Message(email: messageSender, text: messageBody, time:time)
                    self.messages.append(addMessage)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
            print("Current data: \(data)")
          })
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
          self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }          
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = textField.text, let email = Auth.auth().currentUser?.email {
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .long
            let datum = formatter.string(from: date)
            messages.append(Message(email:email,text: message,time:"\(hour):\(minutes)"))
            print(datum)
            db.collection("messages").document(datum).setData([
                "sender": email,
                "text": message,
                "time": "\(datum.suffix(11).prefix(5))"
            ])
        }

    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        //cell.separatorInset = UIEdgeInsets.zero
        if let user = Auth.auth().currentUser?.email{
        if user == messages[indexPath.row].sender {
            cell.bodyLabelCell.text = messages[indexPath.row].body
            cell.leftLabelCell.text = messages[indexPath.row].time
            cell.leftImageCell.isHidden = true
            cell.rightLabelCell.isHidden = true
            cell.rightImageCell.isHidden = false
            cell.leftLabelCell.isHidden = false
        }else{
            cell.bodyLabelCell.text = messages[indexPath.row].body
            cell.rightLabelCell.text = messages[indexPath.row].time
            cell.rightImageCell.isHidden = true
            cell.leftLabelCell.isHidden = true
            cell.leftImageCell.isHidden = false
            cell.rightLabelCell.isHidden = false
        }
        }
        return cell
        
    }
    
    
}
