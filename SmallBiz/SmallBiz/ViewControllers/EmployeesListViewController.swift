//
//  ViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 8/26/22.
//

import UIKit

class EmployeesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var employeeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EmployeeController.shared.loadFromPersistenceStore()
    }
    
    func setupTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        // Make sure our text is not empty.
        guard let text = employeeTextField.text, !text.isEmpty else {
            // Alert?
            return
        }
        
        // Split first and last name
        let fullName = text.components(separatedBy: " ")
        
        EmployeeController.shared.addEmployee(firstName: fullName[0], lastName: fullName[1])
        employeeTextField.text = ""
        tableView.reloadData()
    }
    
}

extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EmployeeController.shared.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        
        let employee = EmployeeController.shared.employees[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(employee.firstName) \(employee.lastName)"
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.delete(employee: employeeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

