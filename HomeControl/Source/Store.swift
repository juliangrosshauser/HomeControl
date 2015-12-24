//
//  Store.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 30/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import SWXMLHash

/// Responsible for reading and persisting information.
class Store {

    /// Parses a structure file.
    ///
    /// - Parameters:
    ///     - path: Structure file path.
    ///     - completionHandler: This closure will be called after parsing is completed.
    ///
    /// - Throws: Parameter of `completionHandler` throws `StoreError`.
    ///
    /// - Returns: `Void`
    ///
    /// - Note: The parameter of the `completionHandler` closure is itself a closure that either returns `[Room]` or throws.
    /// 
    /// This example shows how to use `completionHandler`:
    ///
    ///         let store = Store()
    ///         store.parseStructureFile(structureFilePath) { result in
    ///             let rooms: [Room]
    ///             do {
    ///                 rooms = try result()
    ///             } catch {
    ///                 // Handle `StoreError`
    ///             }
    ///
    ///             // Do something with `rooms`
    ///         }
    ///
    func parseStructureFile(path: String, completionHandler: (() throws -> [Room]) -> ()) {
        // Read structure file content.
        let structureFileContent: String
        do {
            structureFileContent = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        } catch {
            completionHandler { throw StoreError.ReadError }
            return
        }

        // Parse structure file XML and convert it into a dictionary.
        let structureFile = SWXMLHash.parse(structureFileContent)

        // Save category information in dictionary.
        var categories = [String: UInt]()
        for category in structureFile["LoxLIVE"]["Cats"]["Cat"] {
            if let idString = category.element?.attributes["n"], id = UInt(idString), name = category.element?.attributes["name"] {
                categories[name] = id
            }
        }

        // There should be at least 3 categories: lights, blinds and consumers.
        guard categories.count >= 3 else {
            completionHandler { throw StoreError.CategoryError }
            return
        }

        // Get light category.
        guard let lightCategory = categories["Beleuchtung"] else {
            completionHandler { throw StoreError.CategoryError }
            return
        }

        // Find all light XML elements by checking the category attribute.
        let lightXMLIndices = structureFile["LoxLIVE"]["Functions"]["Function"].filter {
            if let categoryString = $0.element?.attributes["cat"] {
                return UInt(categoryString) == lightCategory
            }

            return false
        }

        // Create rooms based on structure file information.
        var rooms = [Room]()
        for room in structureFile["LoxLIVE"]["Rooms"]["Room"] {
            if let idString = room.element?.attributes["n"], id = UInt(idString), name = room.element?.attributes["name"] {
                rooms.append(Room(id: id, name: name))
            }
        }

        // Return rooms in completion handler.
        completionHandler { rooms }
    }
}
