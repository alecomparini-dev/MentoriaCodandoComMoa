//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation
import CoreData

final public class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init(){}
    

    // MARK: - Core Data stack
    lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataMentoria")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            debugPrint(storeDescription)
        })
        return container
    }()

}
