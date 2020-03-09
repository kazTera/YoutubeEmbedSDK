//
//  FirstViewController.swift
//  YoutubeEmbedSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import UIKit
import YoutubeSDK

class FirstViewController: UIViewController {

    let apiKey = "AIzaSyCLUyadr83hwSXY1Yklr2a_rjwpeNdhe0k"
    let baseURL = URL(string: "https://www.googleapis.com/youtube/v3/search")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let y = Youtube(apiversion: "??", apiKey: apiKey, baseURL: baseURL!)
        y.videoSearch(keyword: "HIKAKIN", delegate: self)
    }
}

extension FirstViewController: YoutubeDelegate {
    func youtubeResultFailure(error: Error) {
        print(error)
    }
    func youtubeResultSuccess(videoInfo: YoutubeVideoInfo) {
        print(videoInfo)
    }
}

