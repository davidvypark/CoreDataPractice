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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		
		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
	}
}
