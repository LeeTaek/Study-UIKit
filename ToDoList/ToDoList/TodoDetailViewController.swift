//
//  TodoDetailViewController.swift
//  ToDoList
//
//  Created by 이택성 on 2022/02/03.
//

import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    
    func didFinishSaveData() 
    
}


class TodoDetailViewController: UIViewController {

    weak var delegate: TodoDetailViewControllerDelegate?
    
    // 데이터 저장
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var selectedTodoList: TodoList?     // delete할 때에 선택한 데이터를 보낼 때.
    
    var priority: PriorityLevel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
   
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            
            priority = PriorityLevel(rawValue: hasData.priorityLevel)
            makePriorityButtonDesign()
            
            deleteButton.isHidden = false
            saveButton.setTitle("update", for: .normal)
        } else{
            deleteButton.isHidden = true
            saveButton.setTitle("save", for: .normal)

        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = lowButton.bounds.height / 2
        highButton.layer.cornerRadius = lowButton.bounds.height / 2

    }
    
    
    @IBAction func setPriority(_ sender: UIButton) {

        switch sender.tag {

        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        
       makePriorityButtonDesign()

    }
    
    func makePriorityButtonDesign() {
        
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {

        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
        
       
    }
    
    
    @IBAction func saveTodo(_ sender: Any) {
        
        if selectedTodoList != nil {
            updateTodo()
        }else {
            saveTodo()
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
        
    }

    func saveTodo(){
    
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        
        object.title = titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        
        object.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue

        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }

    
    
    func updateTodo() {
        
        guard let hasData = selectedTodoList else {
            return
        }
                
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.priorityLevel = self.priority?.rawValue ?? PriorityLevel.level1.rawValue
        } catch{
            print(error)
        }
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
        
    }
    
    
    @IBAction func deleteTodo(_ sender: UIButton) {
        guard let hasData = selectedTodoList else {
            return
        }
                
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadedData.first{
                context.delete(loadFirstData)
                
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.saveContext()
                
            }
        }catch{
            print(error)
        }
        
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)

        
    }
    
}
 
 
