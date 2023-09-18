// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ValidatorsSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "ValidatorsSDK", targets: ["ValidatorBuilder"]),
    ],
    
    dependencies: [ ],
    

    targets: [
        .target(
            name: "ValidatorBuilder",
            dependencies: [],
            path: "Sources/Validators"
        ),
        
        .testTarget(name: "ValidatorsSDKTests", dependencies: []),
    
    
    ]
)





