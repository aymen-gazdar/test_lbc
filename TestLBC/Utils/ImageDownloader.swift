//
//  ImageDownloader.swift
//  TestLBC
//
//  Created by Aymen on 12/03/2021.
//

import UIKit

extension UIImageView {

    func loadImageAsync(with urlString: String?, placeHolder: String) {
        guard let urlString = urlString else { return }

        /**
            reinit image and set placeholder
         */
        
        self.image = nil
        self.image = UIImage(named: placeHolder)
        
        /**
            check cache
         */

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }

        /**
            start downloading image
         */
        
        //loader while fetching image
         
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.addSubview(activityIndicator)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            Utils.runOnMainThread {
                activityIndicator.removeFromSuperview()
            }
            
            if let error = error {
                Utils.log(log: error.localizedDescription)
                return
            }

            guard let data = data,
                  let downloadedImage = UIImage(data: data) else {
                return
            }

            ImageCache.shared.save(image: downloadedImage, forKey: urlString)
            Utils.runOnMainThread {
                self?.image = downloadedImage
            }
            
        }

        task.resume()
    }

}

class ImageCache {
    
    //MARK: var let
    
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()
    
    private var observer: NSObjectProtocol!

    //MARK: init / deinit

    private init() {
        
        /**
            remove objects from cache when receiving memory warning
         */
        
        self.observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self.observer!)
    }

    //MARK: methods

    func image(forKey key: String) -> UIImage? {
        return self.cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        self.cache.setObject(image, forKey: key as NSString)
    }
    
}
