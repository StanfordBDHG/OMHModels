// swift-tools-version:5.8

//
// This source file is part of the TemplatePackage open source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "OMHModels",
    platforms: [
        .iOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "OMHModels", targets: ["OMHModels"])
    ],
    targets: [
        .target(
            name: "OMHModels"
        ),
        .testTarget(
            name: "OMHModelsTests",
            dependencies: [
                .target(name: "OMHModels")
            ]
        )
    ]
)
