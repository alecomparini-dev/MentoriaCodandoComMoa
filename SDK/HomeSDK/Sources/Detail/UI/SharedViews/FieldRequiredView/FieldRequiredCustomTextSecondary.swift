//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import DesignerSystemSDKComponent

public class FieldRequiredCustomTextSecondary: CustomTextSecondary {
    
    public override init() {
        super.init()
        self
            .setText("*Campo Obrigatório")
            .setColor(hexColor: "#f46363")
            .setHidden(true)
    }
    
}
