//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

class SummaryAddressTableViewCell: UITableViewCell {
    static let identifier = String(describing: SummaryAddressTableViewCell.self)
    
    private var summaryAddressTextSkeleton: SkeletonBuilder?
    private var summaryAddressTextViewSkeleton: SkeletonBuilder?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - LAZY AREA
    
    lazy var summaryAddressText: CustomText = {
        let comp = CustomText()
            .setText("Endereço")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var summaryAddressTextView: TextViewBuilder = {
        let comp = TextViewBuilder()
            .setTextColor(hexColor: "#282a36")
            .setSize(17)
            .setLineSpacing(10)
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(left: 8, top: 16)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(summaryAddressText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setBottom.equalToSafeArea(-8)
            }
        return comp
    }()

    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else { return applySkeleton()}
        resetSkeleton()
        makeAddress(profilePresenterDTO)
    }
    
    
//  MARK: - PRIVATE AREA

    private func configure() {
        addElements()
        configConstraints()
        configSkeleton()
    }
    
    private func addElements() {
        summaryAddressText.add(insideTo: self.contentView)
        summaryAddressTextView.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        summaryAddressText.applyConstraint()
        summaryAddressTextView.applyConstraint()
    }
    
    private func configSkeleton() {
        summaryAddressTextSkeleton = SkeletonBuilder(component: summaryAddressText).setCornerRadius(4)
        summaryAddressTextViewSkeleton = SkeletonBuilder(component: summaryAddressTextView)
    }
    
    private func applySkeleton() {
        summaryAddressTextSkeleton?.showSkeleton()
        summaryAddressTextViewSkeleton?.showSkeleton()
    }

    private func resetSkeleton() {
        summaryAddressTextSkeleton?.hideSkeleton()
        summaryAddressTextViewSkeleton?.hideSkeleton()
    }

    
//  MARK: - MAKE TEXT VIEW
    private func makeAddress(_ profilePresenterDTO: ProfilePresenterDTO?) {
        summaryAddressTextView.setClearText()
        makeStreet(profilePresenterDTO)
        makeCEP(profilePresenterDTO)
        makeCity(profilePresenterDTO)
    }
    
    private func makeStreet(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let address = profilePresenterDTO?.address else {return}
        if let street =  address.street {
            summaryAddressTextView.setInsertText(street)
            summaryAddressTextView.setInsertText(", ")
        }
        if let number = address.number {
            summaryAddressTextView.setInsertText(number)
            summaryAddressTextView.setInsertText(" - ")
        }
        if let neighborhood = address.neighborhood {
            summaryAddressTextView.setInsertText(neighborhood)
        }
        insertBreakLine()
    }
    
    private func makeCEP(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        if let cep = profilePresenterDTO.address?.cep {
            summaryAddressTextView.setInsertText(cep)
            insertBreakLine()
        }
    }
    
    private func makeCity(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        if let city = profilePresenterDTO.address?.city, let state = profilePresenterDTO.address?.state {
            summaryAddressTextView.setInsertText( city + "-" + state)
        }
    }
    
    private func insertBreakLine() {
        summaryAddressTextView.setInsertText("\n")
    }

}
