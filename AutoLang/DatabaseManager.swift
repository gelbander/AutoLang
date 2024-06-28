//
//  DatabaseManager.swift
//  AutoLang
//
//  Created by Gustaf Elbander on 2024-06-26.
//

import Foundation
import Yams

enum DatabaseError: Error {
    case fileNotFound
    case readError(Error)
    case parseError(Error)
    case invalidData
}

class DatabaseManager {
    var trackedApps: [TrackedApp] = []
    
    func initDB() throws {
        trackedApps = try loadDatabase()
    }
    
    private func loadDatabase() throws -> [TrackedApp] {
        let fileManager = FileManager.default
        let configDir = fileManager.homeDirectoryForCurrentUser.appendingPathComponent(".config/autolang")
        let filePath = configDir.appendingPathComponent("config.yaml")
        
        guard fileManager.fileExists(atPath: filePath.path) else {
            throw DatabaseError.fileNotFound
        }
        
        do {
            let yamlString = try String(contentsOf: filePath, encoding: .utf8)
            let yaml = try Yams.load(yaml: yamlString)
            
            guard let dict = yaml as? [String: Any],
                  let trackedAppsData = dict["tracked_apps"] as? [[String: String]] else {
                throw DatabaseError.invalidData
            }
            
            let apps = trackedAppsData.compactMap { appData -> TrackedApp? in
                guard let name = appData["name"],
                      let language = appData["language"] else {
                    return nil
                }
                return TrackedApp(name: name, language: language)
            }
            
            print("Loaded tracked apps: \(apps)")
            return apps
        } catch let yamlError as YamlError {
            throw DatabaseError.parseError(yamlError)
        } catch {
            throw DatabaseError.readError(error)
        }
    }
}
