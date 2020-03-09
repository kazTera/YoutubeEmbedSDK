//
//  YoutubeAPIClinet.swift
//  YoutubeSDK
//
//  Created by 山本一範 on 2020/03/09.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

class YoutubeAPIClinet: NSObject {
    private var session: URLSession?
    private var receivedData: Data
    private let mimeType: YoutubeAPIClientMimeType
    private var apiRequestDelegate: YoutubeAPIClientDelegate?
    
    init(mimeType: YoutubeAPIClientMimeType) {
        self.receivedData = Data()
        self.mimeType = mimeType
        super.init()
        self.session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: nil)
    }
    
    func request(urlRequest: URLRequest,
                 youtubeAPIClientDelegate: YoutubeAPIClientDelegate) {
        print(youtubeAPIClientDelegate)
        self.apiRequestDelegate = youtubeAPIClientDelegate
        session?.dataTask(with: urlRequest).resume()
    }
}

extension YoutubeAPIClinet: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode),
            response.mimeType == self.mimeType.rawValue else {
                completionHandler(.cancel)
                return
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            self.apiRequestDelegate?.youtubeAPIResultFailure(error: error)
        } else {
            print(self.apiRequestDelegate)
            self.apiRequestDelegate?.youtubeAPIResultSuccess(data: receivedData)
        }
        self.receivedData.removeAll()
    }
}
