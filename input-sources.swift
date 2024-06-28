import Carbon

// Excluded helper-sources
let excludedSources = ["CharacterPaletteIM", "PressAndHold"]

guard let cfSources = TISCreateInputSourceList(nil, false),
      let sources = cfSources.takeRetainedValue() as? [TISInputSource] else {
    print("Failed to retrieve input sources.")
    exit(-1)
}

sources.forEach {
    if let cfID = TISGetInputSourceProperty($0, kTISPropertyInputSourceID) {
        let id = Unmanaged<CFString>.fromOpaque(cfID).takeUnretainedValue() as String
        if !excludedSources.contains(where: id.contains) {
            print(id)
        }
    }
}