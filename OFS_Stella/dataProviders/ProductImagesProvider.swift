//
//  ProductImagesProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Enum declaring an image request that can be sent toward images provider
 * - SeeAlso: ProductImagesProvider
 */
enum ImageRequest {
    /// Declares a thumbnail image request. The associated string must be a
    /// product id.
    case thumb(String)
    /// Declares a detail image request. The associated string must be a
    /// product id.
    case detail(String)
}

extension ImageRequest {
    /// Gets image request's url.
    func url() -> URL {
        var productId : String = ""
        var dimensions : Int = 0
        switch self {
        case .detail(let id):
            dimensions = 750
            productId = id
        case .thumb(let id):
            dimensions = 260
            productId = id
        }
        
        let urlString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/\(dimensions)/f/\(productId).jpg"
        
        
        return URL(string: urlString)!
    }
}

/**
 * This class performs request toward the api to retrieve product's images.
 * The implementation takes advantage of NSURLCache in order to perform image
 * caching. Caching strategy is set up so that if there are a cached image
 * request, image is taken from there. Otherwise the request is sent to the api.
 */
class ProductImagesProvider : GenericDataProvider<UIImage, ImageRequest> {
    private let session : URLSession //= URLSession(configuration: .default)
    private var runningTasks = [Int:URLSessionTask]()
    private var nextTaskId : Int = 0
    
    /// Initializes the product images provider and pass some hints about cache
    /// size capacity.
    /// - parameter memoryCacheCapacityMb: the capacity of the cache in memory,
    /// in megabytes.
    /// - parameter diskCacheCapacityMb: the capacity of the cache stored on
    /// disk.
    init(memoryCacheCapacityMb:Int, diskCacheCapacityMb:Int) {
        let conf = URLSessionConfiguration.default
        conf.urlCache = URLCache(memoryCapacity: memoryCacheCapacityMb * 1024 * 1024,
                                 diskCapacity: memoryCacheCapacityMb * 1024 * 1024,
                                 diskPath: "com.stella.imagesCache")
        conf.requestCachePolicy = .returnCacheDataElseLoad
        
        session = URLSession(configuration:conf)
    }
    
    /// Returns a default images provider instance.
    static func `default`() -> ProductImagesProvider {
        return ProductImagesProvider(memoryCacheCapacityMb:15, diskCacheCapacityMb:20)
    }
    
    /// Requests a product image.
    /// - parameter request: the image request.
    /// - parameter image: Holds the requested images if the request ends
    /// without errors.
    /// - parameter error: Request error, if any.
    /// - returns: a token that can be used to cancel a pending request.
    override func requestData(request:ImageRequest,
                              didRetrieveDataCallback: @escaping (_ image:UIImage?, _ error:Error?) -> Void) -> DataProviderToken {
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
