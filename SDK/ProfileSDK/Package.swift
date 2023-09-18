// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ProfileSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "ProfileSDK", targets: [ "ProfilePresenters", "ProfileUseCaseGateway", "ProfileUI" , "ProfileAuthentication", "ProfileValidators"] )
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/NetworkSDK.git", branch: "develop"),
        .package(url: "https://github.com/alecomparini-dev/DesignerSystemSDK.git", branch: "develop"),
        .package(url: "github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.0.0")),
        .package(name: "ValidatorSDK", path: "../SDK/ValidatorSDK")
    ],
    

    targets: [


//MARK: - INTERFACE ADAPTER LAYER
        .target(
            name: "ProfileUseCases",
            dependencies: [],
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
                "ProfileUseCases",
                .product(name: "NetworkSDK" , package: "NetworkSDK")
            ],
            path: "Sources/3InterfaceAdapter/UseCaseGateway"
        ),
        
        

//  MARK: - DETAILS LAYER
        .target(
            name: "ProfileUI",
            dependencies: [
                "ProfilePresenters",
                .product(name: "DSMComponent" , package: "DesignerSystemSDK"),
                .product(name: "DSMMain" , package: "DesignerSystemSDK")
            ],
            path: "Sources/Detail/UI"
        ),
        
        .target(
            name: "ProfileAuthentication",
            dependencies: [
                "ProfileUseCaseGateway",
                .product(name: "FirebaseAuth" , package: "firebase-ios-sdk")
            ],
            path: "Sources/Detail/Authentication"
        ),
    
        .target(
            name: "ProfileValidators",
            dependencies: [
                "ProfilePresenters",
                .product(name: "ValidatorSDK", package: "ValidatorSDK")
            ],
            path: "Sources/Detail/Validators"
        ),

        
        
//  MARK: - TESTS TARGETS AREA
//        .testTarget(name: "ProfileSDKTests", dependencies: []),
    
    
    ]
)
