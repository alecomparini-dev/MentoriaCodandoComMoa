// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "HomeSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "HomeSDK", targets: [ "HomeUseCaseGateway", "HomeUI"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/alecomparini-dev/DesignerSystemSDK.git", branch: "develop")
    ],
    

    targets: [

//MARK: - DOMAIN
//        .target(
//            name: "HomeDomain",
//            dependencies: [],
//            path: "Sources/1Domain/Domain"
//        ),
        

//MARK: - APPLICATION BUSINESS RULES
        .target(
            name: "HomeUseCases",
            dependencies: [  ],
            path: "Sources/2Application/UseCases"
        ),

        
        
//MARK: - INTERFACE ADAPTER LAYER
                
//        .target(
//            name: "HomePresenters",
//            dependencies: [],
//            path: "Sources/3InterfaceAdapter/Presenters"
//        ),
        
        .target(
            name: "HomeUseCaseGateway",
            dependencies: [
                "HomeUseCases"
            ],
            path: "Sources/3InterfaceAdapter/UseCaseGateway"
        ),
        
    

        //  MARK: - DETAILS LAYER
        .target(
            name: "HomeUI",
            dependencies: [
//                "HomePresenters",
                .product(name: "DesignerSystemSDKComponent" , package: "DesignerSystemSDK"),
                .product(name: "DesignerSystemSDKMain" , package: "DesignerSystemSDK")
            ],
            path: "Sources/Detail/UI"
        ),

                
        
        //  MARK: - TESTS TARGETS AREA
//        .testTarget(name: "HomeSDKTests", dependencies: []),
    
    ]
)





