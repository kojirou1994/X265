import CX265

fileprivate func cStringArray<T>(_ v: T) -> [String] {
  withUnsafeBytes(of: v) { buffer in
    buffer.bindMemory(to: UnsafePointer<CChar>.self)
      .dropLast()
      .map { str in
        String(cString: str)
      }
  }
}

public enum X265Strings {
  public static let profileNames = cStringArray(x265_profile_names)

  public static let presetNames = cStringArray(x265_preset_names)

  public static let fullrangeNames = cStringArray(x265_fullrange_names)

  public static let tuneNames = cStringArray(x265_tune_names)

  public static let motionEstNames = cStringArray(x265_motion_est_names)

  public static let colorspaceNames = cStringArray(x265_source_csp_names)

  public static let videoFormatNames = cStringArray(x265_video_format_names)

  public static let colorPrimariesNames = cStringArray(x265_colorprim_names)

  public static let transferCharacteristicsNames = cStringArray(x265_transfer_names)

  public static let colorMatrixNames = cStringArray(x265_colmatrix_names)

  public static let sarNames = cStringArray(x265_sar_names)

  public static let interlaceNames = cStringArray(x265_interlace_names)

  public static let analysisNames = cStringArray(x265_analysis_names)

}
