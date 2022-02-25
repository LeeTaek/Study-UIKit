//
//  ViewController.swift
//  ToDoList
//
//  Created by 이택성 on 2022/02/03.
//

import UIKit
import CoreData

enum PriorityLevel: Int64 {
    case level1
    case level2
    case level3
}

extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}




class ViewController: UIViewController {

    
    @IBOutlet weak var todoTableView: UITableView!
    
    // AppDelegate에 있는 NSPersistentContainer를 사용하기 위해 공식처럼 쓰이는 문법.
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var todoList = [TodoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "To Do List"
        self.makenNavigationBar()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        fetchData()
        todoTableView.reloadData()
        
        
    }
    
    // DB에 있는 데이터 참조
    func fetchData() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            self.todoList = try context.fetch(fetchRequest)
            
        } catch {
            print(error)
        }
        
    }
    
    func makenNavigationBar() {
        // 오른쪽 add 버튼 추가
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        
        // 네비게이션 바 배경 색 지정. 이를 위해 bar appearance라는걸 만들어야한다.
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance

    }

    
    @objc func addNewTodo() {
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        
        self.present(detailVC, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text = todoList[indexPath.row].title
        
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            
            let dateString = formatter.string(from: hasDate)
            cell.dateLabel.text = dateString
        } else {
            cell.dateLabel.text = ""
        }
        
//        cell.priorityView.backgroundColor =
        
        let priority = todoList[indexPath.row].priorityLevel
       
        let priorityColor = PriorityLevel(rawValue: priority)?.color
        
        cell.priorityView.backgroundColor = priorityColor
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        return cell
    }
    
    // delete할 때 선택한 데이터 값을 보내는 과정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        detailVC.selectedTodoList = todoList[indexPath.row]
        
        self.present(detailVC, animated: true, completion: nil)
        
        // 선택한거 제거
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}



extension ViewController: TodoDetailViewControllerDelegate {
    func didFinishSaveData() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
    
    
    
}

