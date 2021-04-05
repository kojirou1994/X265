import CX265

@dynamicMemberLookup
public final class X265Picture: CustomStringConvertible {

  let ptr: UnsafeMutablePointer<x265_picture>
  let api: X265API

  internal init(ptr: UnsafeMutablePointer<x265_picture>, api: X265API) {
    self.ptr = ptr
    self.api = api
  }

  public subscript<T>(dynamicMember member: WritableKeyPath<x265_picture, T>) -> T {
    get {
      ptr.pointee[keyPath: member]
    }
    set {
      ptr.pointee[keyPath: member] = newValue
    }
  }

  public var description: String {
    .init(describing: ptr.pointee)
  }

  deinit {
    api.ptr.pointee.picture_free(ptr)
  }
}
