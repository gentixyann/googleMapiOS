//
//  YTViewController.swift
//  googleMapiOS
//
//  Created by げんと on 2018/03/31.
//  Copyright © 2018年 Gento. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

//class YTViewController: UITableViewController {
class YTViewController: UIViewController, YTPlayerViewDelegate {
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let youtubeView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 240))
        youtubeView.load(withVideoId: "4BCxqrhsjOw", playerVars: ["playsinline": 1])
        view.addSubview(youtubeView)
    }
    // MARK: - IBAction
    @IBAction func tapPlay(sender: AnyObject) {
        self.playerView.playVideo()
    }
    @IBAction func tapPause(sender: AnyObject) {
        self.playerView.pauseVideo()
    }
    @IBAction func tapStop(sender: AnyObject) {
        self.playerView.stopVideo()
    }
    
}

extension ViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {}
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {}
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {}
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {}
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {}
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor { return .blue }
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? { return nil }
}
