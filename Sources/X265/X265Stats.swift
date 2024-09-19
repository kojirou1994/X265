import CX265

@dynamicMemberLookup
public final class X265Stats: CustomStringConvertible {

  var stats: x265_stats
  let encoder: X265Encoder

  internal init(encoder: X265Encoder) throws {
    guard encoder.api.sizeof_stats == MemoryLayout<x265_stats>.size else {
      fatalError("x265_stats size mismatch!")
    }
    stats = .init()
    self.encoder = encoder
    update()
  }

  public func update() {
    encoder.api.ptr.pointee.encoder_get_stats(encoder.ptr, &stats, numericCast(MemoryLayout<x265_stats>.size))
  }

  public subscript<T>(dynamicMember member: KeyPath<x265_stats, T>) -> T {
    get {
      stats[keyPath: member]
    }
  }

  public var description: String {
    .init(describing: stats)
  }

}
