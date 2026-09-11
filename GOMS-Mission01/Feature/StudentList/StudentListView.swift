//
//  StudentListView.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDataSource    {
    private let students = StudentDummyData.students
    private let tableView = UITableView()
    // 화면에서 보여줄 테이블뷰 객체 작성
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "학생 목록"
            
            tableView.dataSource = self
            tableView.frame = view.bounds
        // 화면 전체 크기만큼 테이블뷰 크기 조정
            view.addSubview(tableView)
            
        }
    func tableView(_ talbeView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return students.count
    }
    func tableView(_ talbeviw: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = students[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = student.name
        cell.textLabel?.text = student.studentNumber
        return cell
    }
    }

