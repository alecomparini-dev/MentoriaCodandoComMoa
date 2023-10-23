//
//  MasksFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation
import ProfilePresenters

public struct MasksFactory {
    
    static public func make() -> [TypeMasks: Masks] {
        var masks: [TypeMasks: Masks] = [:]
        masks.updateValue(CellPhoneMask(), forKey: TypeMasks.cellPhoneMask)
        masks.updateValue(CPFMask(), forKey: TypeMasks.CPFMask)
        masks.updateValue(DateMask(), forKey: TypeMasks.dateMask)
        masks.updateValue(CEPMask(), forKey: TypeMasks.CEPMask)
        return masks

    }
    
}
