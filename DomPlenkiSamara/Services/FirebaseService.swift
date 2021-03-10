//
//  FirebaseService.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.02.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    private init(){}
    let firebaseAuth = Auth.auth()
    let database = Firestore.firestore()
    var isAuthorized = false
    
    func getData() {
        database.collection("categories").getDocuments { (snapshot, error) in
            
            if let error = error {
                
            } else {
                guard let snapshot = snapshot else { return }
                for document in snapshot.documents {
                    
                }
            }
        }
    }
    
    func addUserListener(controller: UIViewController) {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if user == nil {
                
            } else {
                guard let presentedViewController = storyboard.instantiateViewController(identifier: "TabBarController") as? TabBarController else { return }
                self.isAuthorized.toggle()
                controller.show(presentedViewController, sender: nil)
            }
        }
    }
}

extension FirebaseService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
