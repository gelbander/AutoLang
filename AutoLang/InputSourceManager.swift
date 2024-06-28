//
//  InputSourceManager.swift
//  AutoLang
//
//  Created by Gustaf Elbander on 2024-06-26.
//

import Carbon

enum InputSourceError: Error {
    case sourceNotFound
    case selectionFailed(OSStatus)
}

class InputSourceManager {
    func changeInputSource(to inputSourceID: String) throws {
        guard let cfSources = TISCreateInputSourceList([kTISPropertyInputSourceID: inputSourceID] as CFDictionary, false),
              let sources = cfSources.takeRetainedValue() as? [TISInputSource],
              let inputSource = sources.first else {
            throw InputSourceError.sourceNotFound
        }
        
        let result = TISSelectInputSource(inputSource)
        if result != noErr {
            throw InputSourceError.selectionFailed(result)
        }
        
        print("Input source changed successfully to: \(inputSourceID)")
    }
}

