//
//  ViewControllerCoordinator.swift
//  currency-conversion-mvp
//
//  Created by Alessandro Comparini on 17/08/23.
//

import UIKit

protocol ViewControllerCoordinator: AnyObject  {
    associatedtype T
    var coordinator: T? { get set }
}


