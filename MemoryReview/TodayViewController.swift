//
//  TodayViewController.swift
//  MemoryReview
//
//  Created by xqzh on 16/12/5.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  
  var i:CGFloat = 0.0
  let hi = DRHistogramView(frame: CGRect(x: 100, y: 10, width: 200, height: 50))
  let he = DRHistogramView(frame: CGRect(x: 100, y: 10, width: 200, height: 50))
  override func viewDidLoad() {
    super.viewDidLoad()

    self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    
    hi.backgroundColor = UIColor.clear
    hi.histogramColor  = UIColor(red: 34/255.0, green: 111/255.0, blue: 224/255.0, alpha: 1)
    hi.proportion      = 0
    hi.frame           = CGRect(x: 181, y: 50, width: 162, height: 50)
    self.view.addSubview(hi)
    
    
    he.backgroundColor = UIColor.clear
    he.histogramColor  = UIColor(red: 154/255.0, green: 85/255.0, blue: 252/255.0, alpha: 1)
    he.proportion      = 0
    he.direction       = .left
    he.frame           = CGRect(x: 17, y: 50, width: 162, height: 50)
    self.view.addSubview(he)
    
    let timer = Timer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
    let run = RunLoop.current
    run.add(timer, forMode: RunLoopMode.commonModes)
    timer.fire()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func time() {
    i += 10
    var m:CGFloat = 0.0
    
      let mem = MemoryCaculate()
      m = CGFloat(mem.availableMemory())
      print("meory:\(m)")
    
    
    hi.proportion = self.i
    he.proportion = (2048 - m) / 2048.0 * 162.0
  }
  
  private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
      // Perform any setup necessary in order to update the view.
      
      // If an error is encountered, use NCUpdateResult.Failed
      // If there's no update required, use NCUpdateResult.NoData
      // If there's an update, use NCUpdateResult.NewData
      
      completionHandler(NCUpdateResult.newData)
  }
  
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {

    if (activeDisplayMode == .compact) {
      self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 70)
    } else {
      self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 150)
    }
    
  }
    
}
