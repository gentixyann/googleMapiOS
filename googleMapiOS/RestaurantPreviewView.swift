//
//  RestaurantPreviewView.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class RestaurantPreviewView: UIView {
    
    //overrideは継承した親クラスのメソッドを上書きする。継承した親クラスの一部のメソッドの中身を変更したい場合に使う。
    //superで、親クラスのメソッドやプロパティにアクセス。この場合UIViewクラス
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        let goButton = UIButton()
        goButton.frame = CGRect(x: 0,y: 0,width: 100,height:100)
        goButton.backgroundColor = UIColor.yellow
        addSubview(goButton)
        
//        addSubview(videoView)
//        videoView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
//        videoView.topAnchor.constraint(equalTo: topAnchor).isActive=true
//        videoView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
//        videoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    
    let videoView: WKWebView = {
        let v=WKWebView()
        let url = URL(string: "https://www.youtube.com/embed/OVGbAFy36xM")
        v.load(URLRequest(url: url!))
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
