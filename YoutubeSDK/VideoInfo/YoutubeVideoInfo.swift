//
//  YoutubeVideoInfo.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

public struct YoutubeVideoInfo: Codable {
    public let items: [YoutubeVideoItem]
    private let results: [YoutubeVideoItemInfo]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([YoutubeVideoItemInfo].self, forKey: .results)
        if results.isEmpty {
            throw DecodingError.dataCorruptedError(
                forKey: .results,
                in: container,
                debugDescription: "results is empty.")
        }
        var resultItems: [YoutubeVideoItem] = []
        for result in results {
            resultItems.append(result.snippet)
        }
        items = resultItems
    }
    private enum CodingKeys: String,CodingKey {
        case results = "items"
    }
}

fileprivate struct YoutubeVideoItemInfo: Codable {
    let snippet: YoutubeVideoItem
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        snippet = try container.decode(YoutubeVideoItem.self, forKey: .snippet)
    }
    private enum CodingKeys: String, CodingKey {
        case snippet = "snippet"
    }
}
