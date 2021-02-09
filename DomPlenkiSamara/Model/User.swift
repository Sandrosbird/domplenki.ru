//
//  User.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.01.2021.
//

import UIKit

final class User {
    var fullName: String = ""
    var phone: String = ""
    var email: String = ""
    var city: String?
    var street: String?
    var house: String?
    var apartment: String?
    
    init(fullName: String, phone: String, email: String, city: String?, street: String?, house: String?, apartment: String?) {
        self.fullName = fullName
        self.phone = phone
        self.email = email
        self.city = city
        self.street = street
        self.house = house
        self.apartment = apartment
    }
    
     
}
