//
//  MineView.swift
//  HaHaHa
//
//  Created by MAc on 2017/10/31.
//  Copyright © 2017年 MAc. All rights reserved.
//

import UIKit

typealias CornerMarkClick = ()->()

class MineView: UIView {

    var cornerMarkClick: CornerMarkClick?
    
    @IBAction func cornerMarkClick(_ sender: UITapGestureRecognizer) {
        if (cornerMarkClick != nil) {
            self.cornerMarkClick!()
        }
    }
//    @IBOutlet weak var headerBottomView: UIView!
    

}
