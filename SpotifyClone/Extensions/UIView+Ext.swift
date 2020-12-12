//
//  UIView+Ext.swift
//  Todoiest
//
//  Created by Mohammed Iskandar on 08/12/2020.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func getColerFromImage(image : UIImage) {
        
            let smallImage = image.resized(to: CGSize(width: 100, height: 100))
            let kMeans = KMeansClusterer()
            let points = smallImage.getPixels().map({KMeansClusterer.Point(from: $0)})
            let clusters = kMeans.cluster(points: points, into: 3).sorted(by: {$0.points.count > $1.points.count})
            let colors = clusters.map(({$0.center.toUIColor()}))
            guard let mainColor = colors.first else {
                return
            }
            
            self.backgroundColor = mainColor
    }
    
    func setShadow(coler: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = coler.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
}
