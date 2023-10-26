// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ProfileSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],

    products: [
        .library(name: "ProfileSDK", targets: [ "ProfilePresenters", "ProfileUseCaseGateway", "ProfileUI", 
                                                "ProfileAuthentication", "ProfileValidations"] ),
        .library(name: "ProfileSDKMain",  targets: ["ProfileMain"]),
    ],
    
    
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/DesignerSystemSDK.git", branch: "develop"),
        .package(url: "https://github.com/alecomparini-dev/ValidatorSDK.git", branch: "develop"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", branch: "10.15.0"),
    ],
    

    targets: [

//MARK: - DOMAIN
        .target(
            name: "ProfileDomain",
            dependencies: [],
            path: "Sources/1Domain/Domain"
        ),
        

//MARK: - APPLICATION BUSINESS RULES
        .target(
            name: "ProfileUseCases",
            dependencies: [
                "ProfileDomain"
            ],
            path: "Sources/2Application/UseCases"
        ),

        
//MARK: - INTERFACE ADAPTER LAYER
        .target(
            name: "ProfilePresenters",
            dependencies: ["ProfileUseCases"],
            path: "Sources/3InterfaceAdapter/Presenters"
        ),
        
        .target(
            name: "ProfileUseCaseGateway",
            dependencies: [
                "ProfileUseCases"
            ],
            path: "Sources/3InterfaceAdapter/UseCaseGateway"
        ),
        
        .target(
            name: "ProfileMainAdapter",
            dependencies: [
                "ProfileUseCases"
            ],
            path: "Sources/3InterfaceAdapter/ProfileMainAdapter"
        ),

        

//  MARK: - DETAILS LAYER
        .target(
            name: "ProfileUI",
            dependencies: [
                "ProfilePresenters",
                .product(name: "DesignerSystemSDKMain" , package: "DesignerSystemSDK"),
                .product(name: "DesignerSystemSDKComponent" , package: "DesignerSystemSDK")
            ],
            path: "Sources/Detail/UI"
        ),
        
        .target(
            name: "ProfileAuthentication",
            dependencies: [
                "ProfileUseCaseGateway",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ],
            path: "Sources/Detail/Authentication"
        ),
    
        
        .target(
            name: "ProfileValidations",
            dependencies: [
                "ProfilePresenters",
                .product(name: "ValidatorSDK", package: "ValidatorSDK")
            ],
            path: "Sources/Detail/Validations"
        ),

        

//  MARK: - MAIN LAYER
        .target(
            name: "ProfileMain",
            dependencies: [
                "ProfileMainAdapter",
                "ProfileAuthentication"
            ],
            path: "Sources/Main"
        ),

        
//  MARK: - TESTS TARGETS AREA
//        .testTarget(name: "ProfileSDKTests", dependencies: []),
    
    
    ]
)
