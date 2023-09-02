
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit

class HomeView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configBackgroundColor()
        addElements()
        configConstraints()
    }
    
    private func configBackgroundColor() {
        self.backgroundColor = .orange
    }
    
    private func addElements() {
        
    }
    
    private func configConstraints() {
        
    }
    
    
}
