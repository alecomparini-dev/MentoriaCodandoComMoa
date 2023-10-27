//  Created by Alessandro Comparini on 12/10/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


class CPFTableViewCell: UITableViewCell {
    static let identifier = String(describing: CPFTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//  MARK: - LAZY AREA
    
    lazy var cpfLabelText: CustomText = {
        let comp = CustomText()
            .setText("CPF")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()

    lazy var fieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(cpfLabelText.get)
                    .setLeading.equalTo(cpfLabelText.get, .trailing, 4)
            }
        return comp
    }()

    lazy public var cpfTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(cpfLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        resetSkeleton()
        cpfTextField.setText(profilePresenterDTO.cpf)
    }

    
//  MARK: - PUBLIC AREA
    public func configSkeleton() {
        cpfLabelText.setSkeleton { build in
            build
                .showSkeleton(.gradientAnimated)
        }
        cpfTextField.setSkeleton { build in
            build
                .showSkeleton(.gradientAnimated)
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        cpfLabelText.add(insideTo: self.contentView)
        cpfTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        cpfLabelText.applyConstraint()
        cpfTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
        
    private func resetSkeleton() {
        cpfLabelText.get.hideSkeleton()
        cpfTextField.get.hideSkeleton()
    }

    
//    private func configSkeleton() {
//        cpfTextField.get.isSkeletonable = true
//        cpfTextField.get.showAnimatedGradientSkeleton()
//        cpfLabelText.get.isSkeletonable = true
//        cpfLabelText.get.showAnimatedGradientSkeleton()
        
//
//        let skeleton = ViewBuilder()
//            .setBackgroundColor(color: .lightGray)
//            .setConstraints { build in
//                build
//                    .setAlignmentCenterXY.equalToSafeArea
//                    .setWidth.equalToConstant(250)
//                    .setHeight.equalToConstant(50)
//            }
//
//        skeleton.add(insideTo: self.contentView)
//        skeleton.applyConstraint()
//
//        let skeletonLayer = UIView(frame: CGRect(origin: CGPoint(x: -50, y: 0), size: CGSize(width: 50, height: 50)))
//        skeletonLayer.backgroundColor = UIColor.black.withAlphaComponent(0.05)
//        skeletonLayer.clipsToBounds = true
//        skeleton.get.layer.masksToBounds = true
//        skeleton.get.addSubview(skeletonLayer)
//
//
//        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear, .repeat], animations: { [self] in
//            skeletonLayer.frame.origin.x = 250
//        }, completion: nil)
//    }

}

