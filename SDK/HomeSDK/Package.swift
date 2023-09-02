// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "HomeSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "HomeSDK", targets: ["HomePresenters", "HomeUseCaseGateway", "HomeUI"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/NetworkSDK.git", branch: "develop")
    ],
    

    targets: [

        //MARK: - INTERFACE ADAPTER LAYER
                
        .target(
            name: "HomePresenters",
            dependencies: [],
            path: "Sources/3InterfaceAdapter/Presenters"
        ),
        
        .target(
            name: "HomeUseCaseGateway",
            dependencies: [
                .product(name: "NetworkSDK" , package: "NetworkSDK")
            ],
            path: "Sources/3InterfaceAdapter/UseCaseGateway"
        ),
        
    
        

        //  MARK: - DETAILS LAYER
        .target(
            name: "HomeUI",
            dependencies: ["HomePresenters"],
            path: "Sources/Detail/UI"
        ),

                
        
        //  MARK: - TESTS TARGETS AREA
        .testTarget(name: "HomeSDKTests", dependencies: []),
    
    
    ]
)





