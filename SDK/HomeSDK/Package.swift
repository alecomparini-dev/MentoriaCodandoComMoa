// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "HomeSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "HomeSDK", targets: ["HomeUseCases", "HomePresenters", "HomeUseCaseGateway", "HomeUI", "HomeNetwork", "HomeRepositories"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/DesignerSystemSDK.git", branch: "develop"),
        .package(url: "https://github.com/alecomparini-dev/NetworkSDK.git", branch: "develop"),
        .package(url: "https://github.com/alecomparini-dev/DataStorageSDK.git", branch: "feature/2023-12-08/brigde-pattern"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.18.0") ),
    ],
    

    targets: [

//MARK: - DOMAIN
        .target(
            name: "HomeDomain",
            dependencies: [],
            path: "Sources/1Domain/Domain"
        ),
        
        
        .target(
            name: "HomeUseCases",
            dependencies: [ "HomeDomain" ],
            path: "Sources/1Domain/UseCases"
        ),

        
//MARK: - INTERFACE ADAPTER LAYER
                
        .target(
            name: "HomePresenters",
            dependencies: [
                "HomeUseCases"
            ],
            path: "Sources/2InterfaceAdapter/Presenters"
        ),
        
        .target(
            name: "HomeUseCaseGateway",
            dependencies: [
                "HomeUseCases"
            ],
            path: "Sources/2InterfaceAdapter/UseCaseGateway"
        ),
        
    

//  MARK: - DETAILS LAYER
        .target(
            name: "HomeUI",
            dependencies: [
                "HomePresenters",
                "HomeUseCases",
                .product(name: "DesignerSystemSDKComponent" , package: "DesignerSystemSDK"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ],
            path: "Sources/Detail/UI"
        ),

        .target(
            name: "HomeNetwork",
            dependencies: [
                "HomeUseCaseGateway",
                .product(name: "NetworkSDKMain", package: "NetworkSDK")
            ],
            path: "Sources/Detail/Infrastructure/Network"
        ),
        
        .target(
            name: "HomeRepositories",
            dependencies: [
                "HomeUseCaseGateway",
                .product(name: "DataStorageSDKMain", package: "DataStorageSDK"),
            ],
            path: "Sources/Detail/Repositories"
        ),
                
        
        //  MARK: - TESTS TARGETS AREA
//        .testTarget(name: "HomeSDKTests", dependencies: []),
    
    ]
)





