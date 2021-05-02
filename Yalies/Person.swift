//
//  Person.swift
//  Yalies
//
//  Created by Tiger J. Wang on 3/29/21.
//

import Foundation

struct YCStudent: Codable, Hashable {
    var upi: Int?
    var first_name: String
    var middle_name: String?
    var last_name: String
    var image: String?
    var email: String?
    var phone: String?
    
    var year: Int?
    var college: String?
    var eli_whitney: Bool?
    var major: String?
}

//
//struct YCStudent: Person {
//    var year: Int
//}
//
//struct GradStudent: Person {
//    var year: Int
//}
//
//struct FacultyStaff: Person {
//    
//}
