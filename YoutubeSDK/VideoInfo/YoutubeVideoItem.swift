//
//  YoutubeVideoItem.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

public struct YoutubeVideoItem: Codable {
    public let channelId: String
    public let title: String
    public let description: String
    public let thumbnailes: [String: YoutubeThumbnail]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelId = try container.decode(String.self, forKey: .channelId)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        thumbnailes = try container.decode([String: YoutubeThumbnail].self, forKey: .thumbnailes)
        if channelId.isEmpty {
            throw DecodingError.dataCorruptedError(
                forKey: .channelId,
                in: container,
                debugDescription: "channelId is empty")
        } else if title.isEmpty {
            throw DecodingError.dataCorruptedError(
                forKey: .title,
                in: container,
                debugDescription: "titile is empty")
        } else if description.isEmpty {
            // 空文字でも良い
//            throw DecodingError.dataCorruptedError(
//                forKey: .description,
//                in: container,
//                debugDescription: "description is empty")
        } else if thumbnailes.isEmpty {
            throw DecodingError.dataCorruptedError(
                forKey: .thumbnailes,
                in: container,
                debugDescription: "thumbnailes is empty")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case channelId = "channelId"
        case title = "title"
        case description = "description"
        case thumbnailes = "thumbnails"
    }
}
