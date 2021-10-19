//
//  BacklogView.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

final class BacklogTableView: UITableViewController {
    //MARK: - Properties
    let viewModel = TaskVM()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBackloggedTasks()
        tableView.reloadData()
    }
    
    //MARK: - Functions
    func configureTableView() {
        self.title = "Backlog"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.backlogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let task = viewModel.backlogs[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let toggleBacklogStatus = UIContextualAction(style: .normal, title: "Move to\n Today") { [weak self] _, _, completion in
            let task = self?.viewModel.backlogs[indexPath.row]
            task?.isBacklogged = false
            PersistenceController.shared.save()
            self?.viewModel.fetchBackloggedTasks()
            tableView.reloadData()
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let task = self?.viewModel.backlogs[indexPath.row] else { return }
            PersistenceController.shared.container.viewContext.delete(task)
            PersistenceController.shared.save()
            self?.viewModel.fetchBackloggedTasks()
            tableView.reloadData()
            completion(true)
        }
        
        UISwipeActionsConfiguration(actions: [toggleBacklogStatus, deleteAction]).performsFirstActionWithFullSwipe = false

        return UISwipeActionsConfiguration(actions: [toggleBacklogStatus, deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.backlogs.isEmpty ? "Swipe right on today's tasks to store any remaining incomplete tasks here.\n\nSwipe left to remove from Backlog or delete a task." : ""
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

//MARK: - Backlog Coordinator & UIVCRepresentable Configuration
struct BacklogConfigurationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: BacklogTableView(style: .insetGrouped))
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BacklogView_Previews: PreviewProvider {
    static var previews: some View {
        BacklogConfigurationView()
    }
}
