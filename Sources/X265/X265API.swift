import CX265

@dynamicMemberLookup
public final class X265API {
  let ptr: UnsafePointer<x265_api>

  public init(bitDepth: Int32) throws {
    ptr = .init(swift_x265_api_get(bitDepth)!)
  }

  public subscript<T: FixedWidthInteger>(dynamicMember member: KeyPath<x265_api, T>) -> T {
    get {
      ptr.pointee[keyPath: member]
    }
  }

  public var version: String {
    .init(cString: ptr.pointee.version_str)
  }

  public var buildInfo: String {
    .init(cString: ptr.pointee.build_info_str)
  }

  public func newEncoder(parameter: X265Parameter) throws -> X265Encoder {
    .init(ptr: ptr.pointee.encoder_open(parameter.ptr)!,
          api: self)
  }

  public func newParameter() throws -> X265Parameter {
    .init(ptr: ptr.pointee.param_alloc()!, api: self)
  }
  
  public func newPicture(parameter: X265Parameter) throws -> X265Picture {
    let pic = ptr.pointee.picture_alloc()!
    ptr.pointee.picture_init(parameter.ptr, pic)
    return .init(ptr: pic, api: self)
  }

  public func cleanup() {
    ptr.pointee.cleanup()
  }

  //  public var get_slicetype_poc_and_scenecut: (@convention(c) (OpaquePointer?, UnsafeMutablePointer<Int32>?, UnsafeMutablePointer<Int32>?, UnsafeMutablePointer<Int32>?) -> Int32)!
  //
  //  public var get_ref_frame_list: (@convention(c) (OpaquePointer?, UnsafeMutablePointer<OpaquePointer?>?, UnsafeMutablePointer<OpaquePointer?>?, Int32, Int32, UnsafeMutablePointer<Int32>?, UnsafeMutablePointer<Int32>?) -> Int32)!

  public func csvlogOpen(param: X265Parameter) -> UnsafeMutablePointer<FILE> {
    ptr.pointee.csvlog_open(param.ptr)!
  }

  public func csvlogFrame(param: X265Parameter, picture: X265Picture) {
    ptr.pointee.csvlog_frame(param.ptr, picture.ptr)
  }

  public func csvlogEncode(param: X265Parameter, stats: X265Stats,
                           padx: Int32, pady: Int32, argc: Int32, argv: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>) {
    ptr.pointee.csvlog_encode(param.ptr, nil, padx, pady, argc, argv)
  }
  //  public var set_analysis_data: (@convention(c) (OpaquePointer?, UnsafeMutablePointer<x265_analysis_data>?, Int32, UInt32) -> Int32)!

  public func dither(picture: X265Picture, width: Int32, height: Int32,
                     errorBuf: UnsafeMutablePointer<Int16>? = nil, bitDepth: Int32) {
    ptr.pointee.dither_image(picture.ptr, width, height, errorBuf, bitDepth)
  }
}
