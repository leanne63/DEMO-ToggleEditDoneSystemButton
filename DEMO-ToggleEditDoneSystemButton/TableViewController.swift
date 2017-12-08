//
//  TableViewController.swift
//  DEMO-ToggleEditDoneSystemButton
//
//  Created by leanne on 12/7/17.
//  Copyright © 2017 leanne. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
	
	// MARK: - Constants
	
	let cellReuseID = "cellReuseID"
	var cellTitles = ["cell1","cell2","cell3"]
	var cellDetails = ["detail1","detail2","detail3"]
	let toggleEditSelector = #selector(toggleEdit)
	
	
	// MARK: - Lifecycle Overrides
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }

	
	// MARK: - Actions
	
	@IBAction func toggleEdit(_ sender: UIBarButtonItem) {
		guard let systemItem = sender.value(forKey: "systemItem") as? Int else {
			return
		}
		switch systemItem {
		case UIBarButtonSystemItem.edit.rawValue:
			let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: toggleEditSelector)
			doneBarButtonItem.style = .plain
			navigationItem.leftBarButtonItem = doneBarButtonItem
			setEditing(true, animated: true)
		case UIBarButtonSystemItem.done.rawValue:
			let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: toggleEditSelector)
			navigationItem.leftBarButtonItem = editBarButtonItem
			setEditing(false, animated: true)
		default:
			break
		}
	}
	
	
	// MARK: - TableViewDataSource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        let row = indexPath.row
		
		cell.textLabel?.text = cellTitles[row]
		cell.detailTextLabel?.text = cellDetails[row]
		
        return cell
    }
	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			let row = indexPath.row
            cellTitles.remove(at: row)
			cellDetails.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }
	
	
}
