//
//  StudentDetailView.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import UIKit

class StudentDetailViewController: UIViewController {
    let student: Student
    
    init(student : Student){
        self.student = student
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
