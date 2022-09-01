//
//  EmployeeTaskListViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 8/27/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {
        
    // MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var employee: Employee!
    
    override func loadView() {
        super.loadView()
        setViewTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Any other setup can be done here
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setViewTitle() {
        self.navigationItem.title = "\(employee.firstName)'s Tasks"
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = taskTextField.text, !text.isEmpty else { return }
        TaskController.assignTaskTo(employee, taskTitle: text)
        taskTextField.text = ""
        taskTextField.resignFirstResponder()
        tableView.reloadData()
    }
}

extension EmployeeTaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employee.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = employee.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = employee.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employee, taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        TaskController.toggleTaskStatus(employee: employee, task: task)
        tableView.reloadData()
    }
}
