//
//  twitterTimeline.swift
//  igniteApp
//
//  Created by tesco on 28/08/17.
//  Copyright © 2017 tesco. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class twitterTimeline: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
        dataSource = TWTRSearchTimelineDataSource(searchQuery: "#IndiaVsSL", apiClient: client)
        self.showTweetActions = true
        TWTRTweetView.appearance().theme = .dark
}
}
