//
//  YoutubeThumbnail.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

public struct YoutubeThumbnail: Codable {
    public let url: URL
    public let width: Int?
    public let height: Int?
    private let urlStr: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            width = try container.decode(Int?.self, forKey: .width)
        } catch {
            width = nil
        }
        do {
            height = try container.decode(Int?.self, forKey: .height)
        } catch {
            height = nil
        }
        urlStr = try container.decode(String.self, forKey: .urlStr)
        if let url = URL(string: urlStr) {
            self.url = url
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .urlStr,
                in: container,
                debugDescription: "URL format is invalid.")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case urlStr = "url"
        case width = "width"
        case height = "height"
    }
}
