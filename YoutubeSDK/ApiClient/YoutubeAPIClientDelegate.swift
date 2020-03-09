//
//  YoutubeAPIClientDelegate.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

protocol YoutubeAPIClientDelegate: class {
    func youtubeAPIResultSuccess(data: Data)
    func youtubeAPIResultFailure(error: Error)
}
