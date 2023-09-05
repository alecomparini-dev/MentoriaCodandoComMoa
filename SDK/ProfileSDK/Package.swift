// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ProfileSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "ProfileSDK", targets: ["ProfilePresenters", "ProfileUseCaseGateway", "ProfileUI" ])
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/NetworkSDK.git", branch: "develop"),
        .package(url: "https://github.com/alecomparini-dev/DesignerSystemSDK.git", branch: "develop")
    ],
    

    targets: [

        
//MARK: - INTERFACE ADAPTER LAYER
        .target(
            name: "ProfilePresenters",
            dependencies: [],
            path: "Sources/3InterfaceAdapter/Presenters"
        ),
        
        .target(
            name: "ProfileUseCaseGateway",
            dependencies: [
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

        
        
//  MARK: - TESTS TARGETS AREA
//        .testTarget(name: "ProfileSDKTests", dependencies: []),
    
    
    ]
)
