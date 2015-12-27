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

        let categories = parseCategories(structureFile)

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

        let lights = parseLights(parseAccessoryIndices(structureFile, category: lightCategory))
        let rooms = parseRooms(structureFile, lights: lights)

        // Return rooms in completion handler.
        completionHandler { rooms }
    }

    /// Parses a structure file for category information.
    ///
    /// - Parameter structureFile: The structure file to parse.
    ///
    /// - Returns: Dictionary using category names as keys and category IDs as values.
    ///
    private func parseCategories(structureFile: XMLIndexer) -> [String: UInt] {
        // Save category information in dictionary.
        var categories = [String: UInt]()
        for category in structureFile["LoxLIVE"]["Cats"]["Cat"] {
            if let idString = category.element?.attributes["n"], id = UInt(idString), name = category.element?.attributes["name"] {
                categories[name] = id
            }
        }

        return categories
    }

    /// Parses a structure file for accessory XML elements.
    ///
    /// - Parameters:
    ///     - structureFile: The structure file to parse.
    ///     - category: The accessory category.
    ///
    /// - Returns: Array of `XMLIndixer` with specified category.
    ///
    private func parseAccessoryIndices(structureFile: XMLIndexer, category: UInt) -> [XMLIndexer] {
        // Find all accessory XML elements by checking the category attribute.
        let accessoryIndices = structureFile["LoxLIVE"]["Functions"]["Function"].filter {
            if let categoryString = $0.element?.attributes["cat"] {
                return UInt(categoryString) == category
            }

            return false
        }

        return accessoryIndices
    }

    /// Parses a structure file for light information.
    ///
    /// - Parameter indices: Light indices to parse. These indices are found by `Store.parseAccessoryIndices(_:category:)`.
    ///
    /// - Returns: Dictionary using room IDs as keys and light arrays as values.
    ///
    /// - SeeAlso: `Store.parseAccessoryIndices(_:category:)`.
    ///
    private func parseLights(indices: [XMLIndexer]) -> [UInt: [Light]] {
        // Create lights with information of XML element attributes and save them in a dictionary using room IDs as keys.
        var lights = [UInt: [Light]]()
        for light in indices {
            if let roomIDString = light.element?.attributes["room"], roomID = UInt(roomIDString), name = light.element?.attributes["name"], actionID = light.element?.attributes["UUIDaction"] {
                if lights[roomID] == nil {
                    lights[roomID] = [Light]()
                }

                lights[roomID]?.append(Light(name: name, actionID: actionID))
            }
        }

        return lights
    }

    /// Parses a structure file for room information.
    ///
    /// - Parameters:
    ///     - structureFile: The structure file to parse.
    ///     - lights: Dictionary containing room IDs and matching light information.
    ///
    /// - Returns: Array containing all found rooms.
    ///
    private func parseRooms(structureFile: XMLIndexer, lights: [UInt: [Light]]) -> [Room] {
        // Create rooms based on structure file information.
        var rooms = [Room]()
        for room in structureFile["LoxLIVE"]["Rooms"]["Room"] {
            if let idString = room.element?.attributes["n"], id = UInt(idString), name = room.element?.attributes["name"] {
                var room = Room(id: id, name: name)
                room.lights = lights[id]
                rooms.append(room)
            }
        }

        return rooms
    }
}
