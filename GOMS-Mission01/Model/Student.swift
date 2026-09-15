//
//  Student.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import UIKit

struct Student: Identifiable, Hashable {
    let id: UUID
    let name: String
    let studentNumber: String
    let status: StudentStatus

    init(
        id: UUID = UUID(),
        name: String,
        studentNumber: String,
        status: StudentStatus
    ) {
        self.id = id
        self.name = name
        self.studentNumber = studentNumber
        self.status = status
    }
}

enum StudentStatus: String {
    case inSchool = "교내"
    case outing = "외출"
    
    var badgeColor: UIColor {
        switch self {
        case .inSchool:
            return .systemGreen
        case .outing:
            return .systemOrange
        }
    }
}

