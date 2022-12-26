//
//  ChatViewController.swift
//  FireBase test
//
//  Created by JINSEOK on 2022/12/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    var message: [Message] = []
    let messageTextField = UITextField()
    let messageLabel = UILabel()
    let button = UIButton()
    let button1 = UIButton()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        messageTextField.backgroundColor = .white
        messageLabel.backgroundColor = .white
        button.backgroundColor = .blue
        button1.backgroundColor = .blue

        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        button1.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        button.setTitle("Add comment", for: .normal)
        button1.setTitle("check comment", for: .normal)
        view.addSubview(messageTextField)
        view.addSubview(messageLabel)
        view.addSubview(button)
        view.addSubview(button1)
        messageLabel.snp.makeConstraints {
            $0.bottom.equalTo(messageTextField.snp.top).offset(-20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        messageTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(messageTextField.snp.bottom).offset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        button1.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        detectChanges()
    }
    
    func detectChanges() {
        db.collection(Constants.FStore.collectionName).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            print(snapshot.documents.count)
            snapshot.documentChanges.forEach { change in
                switch change.type {
                case .added:
                    print("added")
                case .modified:
                    print("modified")
                case .removed:
                    print("removed")
                }
            }
        }
    }
    
    @objc func loadData() {
        let reference = Firestore.firestore().collection("Messages").document("Chat")
        reference.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error: \(error!)")
                return
            }
            if let message = document.get("Body") as? String {
                self.messageLabel.text = message
            }
        }
    }
    
    @objc func sendPressed(_ sender: UIButton) {
        guard let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email else { return }
        db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField : messageSender,
                                                                          Constants.FStore.bodyField : messageBody,
                                                                          Constants.FStore.dateField : Date().timeIntervalSince1970]) { error in
            if let error = error {
                print("There was an issue saving data to firestore, \(error)")
            } else {
                print("Successfully saved data.")
            }
        }
    }
}


struct Constants {
    struct FStore {
        static let collectionName = "Messages"
        static let senderField = "Sender"
        static let bodyField = "Body"
        static let dateField = "Date"
    }
}

struct Message {
    var sender: String    // 발신자(이메일 주소를 포함)
    var body: String      // 메세지
}
