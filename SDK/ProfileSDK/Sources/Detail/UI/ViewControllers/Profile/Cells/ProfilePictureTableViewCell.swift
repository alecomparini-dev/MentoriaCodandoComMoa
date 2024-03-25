//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

protocol ProfilePictureTableViewCellDelegate: AnyObject {
    func saveProfileImage(_ image: UIImage)
}

class ProfilePictureTableViewCell: UITableViewCell {
    static let identifier = String(describing: ProfilePictureTableViewCell.self)
    weak var delegate: ProfilePictureTableViewCellDelegate?
    
    private struct Skeleton {
        static var profile: SkeletonBuilder?
        static var name: SkeletonBuilder?
        static var fieldOfWord: SkeletonBuilder?
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var profilePictureView: ProfilePictureBuilder = {
        let comp = ProfilePictureBuilder(size: 120)
            .setBackgroundColor(hexColor: "#FFFFFF")
            .setTintColor("#282a36")
            .setCircleProfilePicture()
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(124)
            }
        comp.profileImage.setSkeleton({ build in
            build
        })
        return comp
    }()
    
    lazy var userNameText: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setTextAlignment(.center)
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(profilePictureView.get, .bottom, 16)
                    .setHorizontalAlignmentX.equalToSafeArea
                    .setHeight.equalToConstant(30)
                    .setWidth.greaterThanOrEqualToConstant(260)
            }
        return comp
    }()
    
    lazy var professionText: CustomTextSecondary = {
        let comp = CustomTextSecondary()
            .setSize(20)
            .setTextAlignment(.center)
            .setSkeleton({ build in
                build.setCornerRadius(4)
                    .setColorSkeleton(hexColor: "#aacff9")
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(userNameText.get, .bottom, 8)
                    .setHorizontalAlignmentX.equalToSafeArea
                    .setHeight.equalToConstant(24)
                    .setWidth.greaterThanOrEqualToConstant(160)
            }
        return comp
    }()
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ viewController: UIViewController, profilePresenterDTO: ProfilePresenterDTO?, profileImage: Data?) {
        guard let profilePresenterDTO else {return showSkeleton()}
        configProfilePicture(viewController)
        populateFields(profilePresenterDTO, profileImage)
        resetSkeleton(profilePresenterDTO)
    }

        
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        profilePictureView.add(insideTo: contentView)
        userNameText.add(insideTo: contentView)
        professionText.add(insideTo: contentView)
    }
    
    private func configConstraints() {
        profilePictureView.applyConstraint()
        userNameText.applyConstraint()
        professionText.applyConstraint()
    }
    
    private func populateFields(_ profilePresenterDTO: ProfilePresenterDTO, _ profileImage: Data?) {
        configUserName(profilePresenterDTO.name)
        professionText.setText(profilePresenterDTO.fieldOfWork)
        if let profileImage {
            profilePictureView.setImagePicture(profileImage)
        }
    }
    
    private func configUserName(_ userName: String?) {
        guard let userName else {return}
        let wordsName = userName.split(separator: " ")
        var name = ""
        if wordsName.count == 1 {
            name = String(wordsName[0])
        } else {
            name = String(wordsName[0] + " " + (wordsName.last ?? ""))
        }
        userNameText.setText(name)
    }
    
    private func configProfilePicture(_ viewController: UIViewController) {
        profilePictureView
            .setChooseSource(viewController: viewController, { build in
                build
                    .setTitle("Escolha:")
                    .setOpenCamera { [weak self] image in
                        guard let self, let image, let imageProfile = image.get.image else {return}
                        delegate?.saveProfileImage(imageProfile)
                    }
                    .setOpenGallery { [weak self] image in
                        guard let self, let image, let imageProfile = image.get.image else {return}
                        delegate?.saveProfileImage(imageProfile)
                    }
            })
    }
    
    private func showSkeleton() {
        profilePictureView.profileImage.skeleton?.showSkeleton()
        userNameText.skeleton?.showSkeleton()
        professionText.skeleton?.showSkeleton()
    }
    
    private func resetSkeleton(_ profilePresenterDTO: ProfilePresenterDTO) {
        profilePictureView.profileImage.skeleton?.hideSkeleton()
        if profilePresenterDTO.name == nil || profilePresenterDTO.name!.isEmpty {return}
        userNameText.skeleton?.hideSkeleton()
        professionText.skeleton?.hideSkeleton()
    }
    
}
