import XCTest
import X265

final class X265Tests: XCTestCase {
  func testX265API() throws {
    let api = try XCTUnwrap(X265API(bitDepth: 8))
    XCTAssertEqual(api.api_build_number, X265_BUILD)

    let param = try api.newParameter()
    param.fpsNum = 30000
    param.fpsDenom = 1001
    param.sourceWidth = 1920
    param.sourceHeight = 1080
    
    print(param.description)

    let encoder = try api.newEncoder(parameter: param)

    let stats = try encoder.stats()
    print(stats)
    stats.update()
    print(stats)
  }

  func testProfileStrings() {
    print(X265Strings.profileNames)
    
    print(X265Strings.presetNames)

    print(X265Strings.fullrangeNames)

    print(X265Strings.tuneNames)

    print(X265Strings.motionEstNames)

    print(X265Strings.colorspaceNames)

    print(X265Strings.videoFormatNames)

    print(X265Strings.colorPrimariesNames)

    print(X265Strings.transferCharacteristicsNames)

    print(X265Strings.colorMatrixNames)

    print(X265Strings.sarNames)

    print(X265Strings.interlaceNames)

    print(X265Strings.analysisNames)
  }
}
