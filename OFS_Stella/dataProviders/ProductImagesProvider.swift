//
//  ProductImagesProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

enum ImageRequest {
    case thumb(String)
    case detail(String)
}

extension ImageRequest {
    func url() -> URL {
        var productId : String = ""
        var dimensions : Int = 0
        switch self {
        case .detail(let id):
            dimensions = 260
            productId = id
        case .thumb(let id):
            dimensions = 750
            productId = id
        }
        
        let urlString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/\(dimensions)/f/\(productId).jpg"
        
        
        return URL(string: urlString)!
    }
}

class ProductImagesProvider : GenericDataProvider<UIImage, ImageRequest> {
    private let session = URLSession(configuration: .default)
    private var runningTasks = [Int:URLSessionTask]()
    private var nextTaskId : Int = 0
    
    override func retrieveData(request:ImageRequest,
                               didRetrieveDataCallback: @escaping (UIImage?, Error?) -> Void) -> DataProviderToken {
        let url = request.url()
        let taskId = nextTaskId.advanced(by: 1)
        nextTaskId = taskId
        
        let task = session.dataTask(with: url) { [weak self](data, response, error) in
            if let wself = self {
                wself.runningTasks[taskId] = nil
            }
            
            guard let data = data else {
                didRetrieveDataCallback(nil, nil) // some error here
                return
            }
            didRetrieveDataCallback(UIImage(data: data), nil)
            
        }
        
        runningTasks[taskId] = task
        task.resume()
        
        return taskId
    }
    
    override func cancelRequest(token: DataProviderToken) {
        let taskId = token as! Int
        guard let task = runningTasks[taskId] else {
            return
        }
        
        runningTasks[taskId] = nil
        task.cancel()
    }
}
