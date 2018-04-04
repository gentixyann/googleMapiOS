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

//class RestaurantPreviewView: UIView {
class RestaurantPreviewView: UIView {
    
    //overrideは継承した親クラスのメソッドを上書きする。継承した親クラスの一部のメソッドの中身を変更したい場合に使う。
    //superで、親クラスのメソッドやプロパティにアクセス。この場合UIViewクラス
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setData(title: String, img: UIImage, price: Int) {
        lblTitle.text = title
        imgView.image = img
        lblPrice.text = "$\(price)"
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
        goButton.addTarget(self, action: #selector(ViewController.goNext(_:)), for: .touchUpInside)
        addSubview(goButton)
        
//        addSubview(videoView)
//        videoView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
//        videoView.topAnchor.constraint(equalTo: topAnchor).isActive=true
//        videoView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
//        videoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
//        containerView.addSubview(lblTitle)
//        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive=true
//        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive=true
//        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
//        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive=true
//
//        addSubview(imgView)
//        imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
//        imgView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive=true
//        imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
//        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
//
//        addSubview(lblPrice)
//        lblPrice.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
//        lblPrice.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive=true
//        lblPrice.widthAnchor.constraint(equalToConstant: 90).isActive=true
//        lblPrice.heightAnchor.constraint(equalToConstant: 40).isActive=true
    }
    
//    @objc func goNext(_ sender: UIButton) {
//        let next2vc = DetailsVC()
//        //ここで次の画面の色を指定してる
//        next2vc.view.backgroundColor = UIColor.white
//        self.navigationController?.pushViewController(next2vc, animated: true)
//    }

    
    
    
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
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image=#imageLiteral(resourceName: "restaurant1")
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblPrice: UILabel = {
        let lbl=UILabel()
        lbl.text="$12"
        lbl.font=UIFont.boldSystemFont(ofSize: 32)
        lbl.textColor=UIColor.white
        lbl.backgroundColor=UIColor(white: 0.2, alpha: 0.8)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds=true
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
