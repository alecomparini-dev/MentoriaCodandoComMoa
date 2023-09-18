// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ValidatorSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "ValidatorSDK", targets: ["ValidatorSDK"]),
    ],
    
    dependencies: [ ],
    

    targets: [
        .target(
            name: "ValidatorSDK",
            dependencies: [],
            path: "Sources/Validators"
        ),
        
//        .testTarget(name: "ValidatorsSDKTests", dependencies: []),
    
    ]
)





