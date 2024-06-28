//
//  TrackedApp.swift
//  AutoLang
//
//  Created by Gustaf Elbander on 2024-06-26.
//

struct TrackedApp {
    let name: String
    let language: String
    
    init?(name: String, language: String) {
        guard !name.isEmpty, !language.isEmpty else {
            return nil
        }
        self.name = name
        self.language = language
    }
}
