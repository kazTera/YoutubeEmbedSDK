//
//  YoutubeDelegate.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

public protocol YoutubeDelegate: class {
    func youtubeResultSuccess(videoInfo: YoutubeVideoInfo)
    func youtubeResultFailure(error: Error)
}
