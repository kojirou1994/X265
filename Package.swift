// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "X265",
  products: [
    .library(
      name: "X265",
      targets: ["X265"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kojirou1994/CX265.git", .branch("main")),
  ],
  targets: [
    .target(
      name: "X265",
      dependencies: [
        .product(name: "CX265", package: "CX265")
      ]),
    .testTarget(
      name: "X265Tests",
      dependencies: ["X265"]),
  ]
)
