//
//  InfoViewController.swift
//  CoreDataPractice
//
//  Created by David Park on 8/21/16.
//  Copyright © 2016 DavidVYPark. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

	@IBOutlet weak var personLabel: UILabel!
	@IBOutlet weak var dogLabel: UILabel!
	@IBOutlet weak var boneLabel: UILabel!
	@IBOutlet weak var doghouseLabel: UILabel!
	
	var dog: Dog!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateLabels()
	}
	
	func updateLabels() {
		personLabel.text = dog.person?.name
		dogLabel.text = dog.name
		boneLabel.text = dog.bone?.type
		doghouseLabel.text = dog.doghouse?.type
	}
	
	
	
}
