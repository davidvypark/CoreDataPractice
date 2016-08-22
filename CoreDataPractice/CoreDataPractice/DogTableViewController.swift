//
//  DogTableViewController.swift
//  CoreDataPractice
//
//  Created by David Park on 8/21/16.
//  Copyright © 2016 DavidVYPark. All rights reserved.
//

import UIKit

class DogTableViewController: UITableViewController {
	
	let cellIdentifier = "dogCell"
	var person: Person!
	var dogs = [Dog]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//dogs = person.dog.map{ $0 }
		
		for dog in person.dog! {
			dogs.append(dog)
		}
		
		tableView.reloadData()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dogs.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		
		cell.textLabel!.text = dogs[indexPath.row].name
		
		return cell
		
	}
	

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		let selectedRow = tableView.indexPathForSelectedRow!.row
		let dog = dogs[selectedRow]
		
		let destinationVC = segue.destinationViewController as! InfoViewController
		destinationVC.dog = dog
	}
}
