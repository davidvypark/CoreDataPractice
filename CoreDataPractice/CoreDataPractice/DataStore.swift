//
//  DataStore.swift
//  CoreDataPractice
//
//  Created by David Park on 8/21/16.
//  Copyright © 2016 DavidVYPark. All rights reserved.
//

import Foundation
import CoreData

class DataStore {

	static let sharedInstance = DataStore()
	
	var persons = [Person]()
	
	func saveContext() {
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch {
				let nserror = error as NSError
				print("Error: \(nserror) | \(nserror.userInfo)")
				abort()
			}
		}
	}
	
	func fetchData() {
		
		print("Fetching Data")
		let fetchRequest = NSFetchRequest(entityName: Person.entityName)
		
		do {
			persons = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Person]
		} catch {
			let nserror = error as NSError
			print("Error: \(nserror) | \(nserror.userInfo)")
		}
		
		if persons.isEmpty {
			generateTestData()
		}
	}

	func generateTestData() {
		
		print("generating Data")
		
		let person1 = NSEntityDescription.insertNewObjectForEntityForName(Person.entityName, inManagedObjectContext: managedObjectContext) as! Person
		
		let dog1 = NSEntityDescription.insertNewObjectForEntityForName(Dog.entityName, inManagedObjectContext: managedObjectContext) as! Dog
		
		let bone1 = NSEntityDescription.insertNewObjectForEntityForName(Bone.entityName, inManagedObjectContext: managedObjectContext) as! Bone
		
		let doghouse1 = NSEntityDescription.insertNewObjectForEntityForName(Doghouse.entityName, inManagedObjectContext: managedObjectContext) as! Doghouse
		
		person1.name = "David"
		
		dog1.name = "Kobe"
		bone1.type = "Chicken"
		dog1.bone = bone1
		doghouse1.type = "Mansion"
		dog1.doghouse = doghouse1
		person1.dog?.insert(dog1)
		
		
		
		
		saveContext()
		fetchData()
	}

	// MARK: - Core Data stack
	// Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
	// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
	
	lazy var managedObjectContext: NSManagedObjectContext = {
		// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
		let coordinator = self.persistentStoreCoordinator
		var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator
		return managedObjectContext
	}()
	
	lazy var managedObjectModel: NSManagedObjectModel = {
		// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
		let modelURL = NSBundle.mainBundle().URLForResource("CoreDataPractice", withExtension: "momd")!
		return NSManagedObjectModel(contentsOfURL: modelURL)!
	}()
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		// The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
		// Create the coordinator and store
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite") // change this?
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
		} catch {
			// Report any error we got.
			var dict = [String: AnyObject]()
			dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
			dict[NSLocalizedFailureReasonErrorKey] = failureReason
			
			dict[NSUnderlyingErrorKey] = error as NSError
			let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
			// Replace this with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
			abort()
		}
		
		return coordinator
	}()
	
	//MARK: Application's Documents directory
	// Returns the URL to the application's Documents directory.
	
	lazy var applicationDocumentsDirectory: NSURL = {
		// The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.count-1]
	}()
}