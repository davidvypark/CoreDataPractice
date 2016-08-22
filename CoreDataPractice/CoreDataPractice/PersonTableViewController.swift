//
//  PersonTableViewController.swift
//  CoreDataPractice
//
//  Created by David Park on 8/21/16.
//  Copyright © 2016 DavidVYPark. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
	
	let cellIdentifier = "personCell"
	
	let store = DataStore.sharedInstance
	var persons = [Person]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		store.fetchData()
		persons = store.persons
		tableView.reloadData()
		print (store.persons.count)
		print(persons.count)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return persons.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		cell.textLabel!.text = persons[indexPath.row].name
		
		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "dogSegue" {
		
			let selectedRow = tableView.indexPathForSelectedRow?.row
			let selectedPerson = persons[selectedRow!]
			
			let destinationVC = segue.destinationViewController as! DogTableViewController
			destinationVC.person = selectedPerson
		}
	}
}
