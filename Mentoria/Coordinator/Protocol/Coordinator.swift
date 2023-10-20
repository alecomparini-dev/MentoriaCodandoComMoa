//
//  Coordinator.swift
//  currency-conversion-mvp
//
//  Created by Alessandro Comparini on 15/08/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: Coordinator? { get set }
    
    var navigationController: NavigationController { get }
    
    init(_ navigationController: NavigationController)
    
    func start()

}
