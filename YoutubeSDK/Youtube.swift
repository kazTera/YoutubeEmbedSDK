//
//  Youtube.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

public class Youtube {
    weak var delegate: YoutubeDelegate?
    private let apiClient = YoutubeAPIClinet(mimeType: .json)
    private let jsonDecoder = JSONDecoder()
    
    private let apiVersion: String
    private let apiKey: String
    private let baseURL: URL
    
    public init(apiversion: String,
                apiKey: String,
                baseURL: URL) {
        self.apiVersion = apiversion
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    public func videoSearch(keyword: String, delegate: YoutubeDelegate) {
        self.delegate = delegate
        if let url = URL(string: baseURL.absoluteString + "?type=video&part=snippet&q=\(keyword)&key=\(apiKey)") {
            print(url)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            apiClient.request(urlRequest: urlRequest, youtubeAPIClientDelegate: self)
        } else {
            debugPrint("failer create url....")
        }
    }
}

extension Youtube: YoutubeAPIClientDelegate {
    func youtubeAPIResultSuccess(data: Data) {
        do {
            let result = try jsonDecoder.decode(YoutubeVideoInfo.self, from: data)
            self.delegate?.youtubeResultSuccess(videoInfo: result)
        } catch let e {
            self.delegate?.youtubeResultFailure(error: e)
        }
    }
    
    func youtubeAPIResultFailure(error: Error) {
        self.delegate?.youtubeResultFailure(error: error)
    }
}
