// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "HomeSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "HomePresenters", targets: ["HomePresenters"]),
        .library(name: "HomeUseCaseGateway", targets: ["HomeUseCaseGateway"]),
        .library(name: "HomeUI", targets: ["HomeUI"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/NetworkSDK.git", branch: "develop")
    ],
    

    targets: [

        //MARK: - INTERFACE ADAPTER LAYER
                
        .target(
            name: "HomePresenters",
            dependencies: [],
            path: "Sources/Layer3_InterfaceAdapter/Presenters"
        ),
        
        .target(
            name: "HomeUseCaseGateway",
            dependencies: [
                .product(name: "Network" , package: "NetworkSDK")
            ],
            path: "Sources/Layer3_InterfaceAdapter/UseCaseGateway"
        ),
        
    

        //  MARK: - DETAILS LAYER
        .target(
            name: "HomeUI",
            dependencies: ["HomePresenters"],
            path: "Sources/Layer4_Detail/UI",
            linkerSettings: [.linkedFramework("UIKit")]
        ),

        
        //  MARK: - TESTS TARGETS AREA
        .testTarget(name: "HomeSDKTests", dependencies: []),
    
    
    ]
)
