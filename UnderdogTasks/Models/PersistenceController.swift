//
//  PersistenceController.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import CoreData
struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        for _ in 0..<10 {
            let task = Task(context: controller.container.viewContext)
            task.title        = "Mock Title"
            task.notes        = "These are mock notes for this mock Task."
            task.date         = Date()
            task.isComplete   = false
            task.isBacklogged = false
        }
        
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Task")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                print("• Error in \(#function), Line\(#line): \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("• Error in \(#function), Line\(#line): \(error.localizedDescription)")
            }
        }
    }
}
