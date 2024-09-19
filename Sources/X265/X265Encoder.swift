import CX265

/// Note:
/// There is one caveat to having multiple encoders within a single process. All of the encoders must use the same maximum CTU size because many global variables are configured based on this size. Encoder allocation will fail if a mis-matched CTU size is attempted. If no encoders are open, x265_cleanup() can be called to reset the configured CTU size so a new size can be used.
public final class X265Encoder {
  internal init(ptr: OpaquePointer, api: X265API) {
    self.ptr = ptr
    self.api = api
  }

  internal let ptr: OpaquePointer
  internal let api: X265API

  func copyParam(to dst: borrowing X265Parameter) {
    api.ptr.pointee.encoder_parameters(ptr, dst.ptr)
  }

  func reconfig(param: borrowing X265Parameter) -> Bool {
    api.ptr.pointee.encoder_reconfig(ptr, param.ptr) == 0
  }

//  func reconfigZone(param: X265Parameter) -> Bool {
//    api.ptr.pointee.encoder_reconfig_zone(ptr, param.ptr.pointee.rc.zones) == 0
//  }

  public func encoderHeaders(ppNal: UnsafeMutablePointer<UnsafeMutablePointer<x265_nal>?>?,
                     piNal: UnsafeMutablePointer<UInt32>?) -> Bool {
    api.ptr.pointee.encoder_headers(ptr, ppNal, piNal) >= 0
  }

  /* x265_encoder_encode:
   *      encode one picture.
   *      *pi_nal is the number of NAL units outputted in pp_nal.
   *      returns negative on error, zero if no NAL units returned.
   *      the payloads of all output NALs are guaranteed to be sequential in memory. */
  public func encode(ppNal: UnsafeMutablePointer<UnsafeMutablePointer<x265_nal>?>?,
              piNal: UnsafeMutablePointer<UInt32>?,
              picIn: X265Picture, picOut: X265Picture) -> Bool {
    api.ptr.pointee.encoder_encode(ptr, ppNal, piNal, picIn.ptr, picOut.ptr) >= 0
  }

  public func stats() throws -> X265Stats {
    try .init(encoder: self)
  }

  public func log(argc: Int32, argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) {
    api.ptr.pointee.encoder_log(ptr, argc, argv)
  }

  public func intraRefresh() -> Bool {
    api.ptr.pointee.encoder_intra_refresh(ptr) == 0
  }

  public func ctuInfo(poc: CInt, ctu: UnsafeMutablePointer<UnsafeMutablePointer<x265_ctu_info_t>?>) -> Bool {
    api.ptr.pointee.encoder_ctu_info(ptr, poc, ctu) != 0
  }

  deinit {
    api.ptr.pointee.encoder_close(ptr)
  }
}
