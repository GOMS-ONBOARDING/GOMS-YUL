//
//  StudentDetailView.swift
//  GOMS-Mission01
//
//  Created by 안율 on 9/10/26.
//

import UIKit

class StudentDetailViewController: UIViewController {
    private var student : Student
    private let onStatusChange: (Student) -> Void
    private let statusButton = UIButton(type: .system)
    private let statusValueLabel = UILabel()
    private let returnTimeValueLabel = UILabel()보
    
    init(student : Student, onStatusChange: @escaping (Student) -> Void){
        self.student = student
        self.onStatusChange = onStatusChange
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "학생 상세"
        view .backgroundColor = .systemBackground
        configureLayout()
        updateButtonTitle()
        refreshUI()
    }
    
    private func updateButtonTitle(){
        let buttonText = student.status == .inSchool ? "외출 처리" : "복귀 처리"
        statusButton.setTitle(buttonText, for : .normal)
    }
    private func refreshUI(){
        statusValueLabel.text = student.displayStatus.rawValue
        if let time = student.expectedReturnTime{
            returnTimeValueLabel.text = formattedTime(time)
        }else {
            returnTimeValueLabel.text = "-"
        }
    }
    
    @objc private func statusButtonTapped() {
        if student.status == .inSchool{
            presentReturnTimePicker()
        } else {
            student.status = .inSchool
            student.expectedReturnTime = nil
            refreshUI()
            onStatusChange(student)
            
        }
    }
    
    private func presentReturnTimePicker(){
        let alert = UIAlertController(title: "복귀 예정 시간", message: nil, preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        alert.view?.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50)
        ])
        alert.view?.heightAnchor.constraint(equalToConstant:250).isActive = true
        alert.addAction(UIAlertAction(title: "확인",style: .default) { [weak self]_ in guard let self else {return}
            self.student.status = .outing
            self.student.expectedReturnTime = datePicker.date
            self.updateButtonTitle()
            self.refreshUI()
            self.onStatusChange(self.student)
        })
    }
    private func configureLayout() {
        
        statusButton.addTarget(self, action: #selector(statusButtonTapped), for : .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusButton)
        
        NSLayoutConstraint.activate([
            statusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40)
        ])
        
        
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(infoRow(title: "이름", value: student.name))
        stack.addArrangedSubview(infoRow(title: "학번", value: student.studentNumber))
        stack.addArrangedSubview(infoRow(title: "현재 상태", value: student.status.rawValue))
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
}
    private func infoRow(title: String, value: String) -> UIView{
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        
        let titleLable = UILabel()
        titleLable.text = title
        titleLable.font = .preferredFont(forTextStyle: .caption1)
        titleLable.textColor = .secondaryLabel
        
        let valueLable = UILabel()
        valueLable.text = value
        valueLable.font = .preferredFont(forTextStyle: .caption1)
        
        container.addArrangedSubview(titleLable)
        container.addArrangedSubview(valueLable)
        
        return container
    }

