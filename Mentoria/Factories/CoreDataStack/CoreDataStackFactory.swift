//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation
import CoreData

public struct CoreDataStackFactory {
    
    func make() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataMentoria")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print(storeDescription)
        })
        return container
    }()

    
    
    
}

