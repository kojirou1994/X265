import CX265

@dynamicMemberLookup
public final class X265Parameter: CustomStringConvertible {
  internal let ptr: UnsafeMutablePointer<x265_param>
  internal let api: X265API

  internal init(ptr: UnsafeMutablePointer<x265_param>, api: X265API) {
    self.ptr = ptr
    self.api = api

    reset()
  }

  public subscript<T>(dynamicMember member: WritableKeyPath<x265_param, T>) -> T {
    get {
      ptr.pointee[keyPath: member]
    }
    set {
      ptr.pointee[keyPath: member] = newValue
    }
  }

  public func reset() {
    api.ptr.pointee.param_default(ptr)
  }

  public enum ParseError: Error {
    case badName
    case badValue
  }

  public func parse(name: String, value: String) throws {
    let r = api.ptr.pointee.param_parse(ptr, name, value)
    switch r {
    case X265_PARAM_BAD_NAME:
      throw ParseError.badName
    case X265_PARAM_BAD_VALUE:
      throw ParseError.badValue
    default:
      return
    }
  }

  public func parseZone(name: String, value: String) throws {
    let r = api.ptr.pointee.zone_param_parse(ptr, name, value)
    switch r {
    case X265_PARAM_BAD_NAME:
      throw ParseError.badName
    case X265_PARAM_BAD_VALUE:
      throw ParseError.badValue
    default:
      return
    }
  }

  public func apply(profile: String) -> Bool {
    api.ptr.pointee.param_apply_profile(ptr, profile) == 0
  }

  public func apply(preset: UnsafePointer<Int8>?, tune: UnsafePointer<Int8>?) -> Bool {
    api.ptr.pointee.param_default_preset(ptr, preset, tune) == 0
  }

  public var description: String {
    .init(describing: ptr.pointee)
  }

  deinit {
    api.ptr.pointee.param_free(ptr)
  }
}
