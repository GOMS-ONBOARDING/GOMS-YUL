//
//  Student.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import Foundation
import UIKit

struct Student: Identifiable, Hashable {
    let id: UUID
    let name: String
    let studentNumber: String
    var status: StudentStatus
    var expectedReturnTime: Date?

    init(
        id: UUID = UUID(),
        name: String,
        studentNumber: String,
        status: StudentStatus,
        expectedReturnTime: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.studentNumber = studentNumber
        self.status = status
        self.expectedReturnTime = expectedReturnTime
    }

    var displayStatus: StudentStatus {
        if status == .outing, let expected = expectedReturnTime, Date() > expected {
            return .late
        }
        return status
    }
}

enum StudentStatus: String {
    case inSchool = "교내"
    case outing = "외출"
    case late = "지각"
    
    var toggled: StudentStatus{
        switch self{
        case .inSchool:
            return .outing
        case .outing,
                .late: return .inSchool
        }
    }
    
    var badgeColor: UIColor{
        switch self {
        case .inSchool:
            return .systemGreen
        case .outing:
            return .systemOrange
        case .late: return .systemRed
        }
    }
}
    

