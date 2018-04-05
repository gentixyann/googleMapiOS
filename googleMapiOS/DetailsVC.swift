//
//  DetailsVC.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class DetailsVC: UIViewController {
    
//    struct State {
//        let url: String
//        let i: Int
//    }
    
//    let states = [
//        State(url:"https://www.youtube.com/embed/OVGbAFy36xM", i:1),
//        State( url:"ha2", i:2),
//        State( url:"ha3", i:3),
//        State( url:"ha4", i:4),
//        State( url:"ha5", i:5),
//        State( url:"ha6", i:6)
//    ]
    
    //var passedData = (title: "Name", img: #imageLiteral(resourceName: "restaurant1"), price: 0)
    
    var passedData: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(myScrollView)
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        myScrollView.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive=true
        containerView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        containerView.addSubview(videoView)
        videoView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive=true
        videoView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive=true
        videoView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive=true
        videoView.heightAnchor.constraint(equalToConstant: 400).isActive=true
    }
    
    let videoView: WKWebView = {
        let v=WKWebView()
        let url = URL(string: "https://www.youtube.com/embed/OVGbAFy36xM")
        v.load(URLRequest(url: url!))
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.showsHorizontalScrollIndicator=false
        return scrollView
    }()
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        //v.image = #imageLiteral(resourceName: "restaurant1")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds=true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblPrice: UILabel = {
        let lbl=UILabel()
        lbl.text = "Price"
        lbl.font=UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor(white: 0.5, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblDescription: UILabel = {
        let lbl=UILabel()
        lbl.text = "Description"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}
