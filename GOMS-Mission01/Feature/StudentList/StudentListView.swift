//
//  StudentListView.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var students : [Student]
    private let tableView = UITableView()
    
    init(students: [Student]) {
        self.students = students
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "학생 목록"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        var config = cell.defaultContentConfiguration()
        config.text = student.name
        config.secondaryText = student.studentNumber
        cell.contentConfiguration = config

        let badge = UILabel()
        badge.text = student.status.rawValue
        badge.font = .systemFont(ofSize: 13, weight: .semibold)
        badge.textColor = student.status.badgeColor
        badge.sizeToFit()
        cell.accessoryView = badge

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let student = students[indexPath.row]
        let detailVC = StudentDetailViewController(student: student){[weak self] updatedStudent in guard let self else {return}
            self.students[indexPath.row] = updatedStudent
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
