/**
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** CreateEntity. */
public struct CreateEntity {

    /// The name of the entity.
    public var entity: String

    /// The description of the entity.
    public var description: String?

    /// Any metadata related to the value.
    public var metadata: [String: JSON]?

    /// An array of entity values.
    public var values: [CreateValue]?

    /// Whether to use fuzzy matching for the entity.
    public var fuzzyMatch: Bool?

    /**
     Initialize a `CreateEntity` with member variables.

     - parameter entity: The name of the entity.
     - parameter description: The description of the entity.
     - parameter metadata: Any metadata related to the value.
     - parameter values: An array of entity values.
     - parameter fuzzyMatch: Whether to use fuzzy matching for the entity.

     - returns: An initialized `CreateEntity`.
    */
    public init(entity: String, description: String? = nil, metadata: [String: JSON]? = nil, values: [CreateValue]? = nil, fuzzyMatch: Bool? = nil) {
        self.entity = entity
        self.description = description
        self.metadata = metadata
        self.values = values
        self.fuzzyMatch = fuzzyMatch
    }
}

extension CreateEntity: Codable {

    private enum CodingKeys: String, CodingKey {
        case entity = "entity"
        case description = "description"
        case metadata = "metadata"
        case values = "values"
        case fuzzyMatch = "fuzzy_match"
        static let allValues = [entity, description, metadata, values, fuzzyMatch]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        entity = try container.decode(String.self, forKey: .entity)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        metadata = try container.decodeIfPresent([String: JSON].self, forKey: .metadata)
        values = try container.decodeIfPresent([CreateValue].self, forKey: .values)
        fuzzyMatch = try container.decodeIfPresent(Bool.self, forKey: .fuzzyMatch)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(entity, forKey: .entity)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(values, forKey: .values)
        try container.encodeIfPresent(fuzzyMatch, forKey: .fuzzyMatch)
    }

}
