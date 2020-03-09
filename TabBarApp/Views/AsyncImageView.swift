//
//  AsyncImage.swift
//  Testbed-storyboard
//
//  Created by Gary on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class AsyncImageView: UIImageView {
    static let placeHolderImage = UIImage(named: "Loading")

    init(frame: CGRect, urlString: String?) {
        super.init(frame: frame)

        self.frame = frame
        self.bounds = frame
        self.contentMode = .scaleAspectFit

        // self.image = AsyncImageView.placeHolderImage
        if let urlString = urlString {
            downloadImage(urlString: urlString)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func downloadImage(urlString: String) {
        // these steps aren't really necessary for URLs because they come from a known source. worst case should be not found.
        guard let localValidatedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid URL string")
            return
        }
        guard let url = URL(string: localValidatedURLString) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
                return
            }
        }.resume()

    }

}
