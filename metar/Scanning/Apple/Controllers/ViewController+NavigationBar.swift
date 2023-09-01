/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Navigation bar management for the main view controller.
*/

import Foundation
import UIKit

extension ViewController {
    
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "clear"), style: .plain, target: self, action: #selector(clear))
        navigationItem.title = "重建拍摄"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        self.navigationItem.title = @"重建拍摄";
//        NSDictionary *atts = @{
//                               NSForegroundColorAttributeName:[UIColor whiteColor]
//                               };
//        [[UINavigationBar appearance] setTitleTextAttributes:atts];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"clear"] style:0 target:self action:@selector(clear)];
        
        
        
//        backButton = UIBarButtonItem(title: "Back", style: .plain, target: self,
//                                     action: #selector(previousButtonTapped(_:)))
//        mergeScanButton = UIBarButtonItem(title: "Merge Scans…", style: .plain, target: self,
//                                          action: #selector(addScanButtonTapped(_:)))
//        let startOverButton = UIBarButtonItem(title: "Restart", style: .plain, target: self,
//                                              action: #selector(restartButtonTapped(_:)))
//        let navigationItem = UINavigationItem(title: "Start")
//        navigationItem.leftBarButtonItem = backButton
//        navigationItem.rightBarButtonItem = startOverButton
//        navigationBar!.items = [navigationItem]
//
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
    }
    
    func clear() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showBackButton(_ show: Bool) {
//        guard let navBar = navigationBar, let navItem = navBar.items?.first else { return }
//        if show {
//            navItem.leftBarButtonItem = backButton
//        } else {
//            navItem.leftBarButtonItem = nil
//        }
    }
    
    func showMergeScanButton() {
//        guard let navBar = navigationBar, let navItem = navBar.items?.first else { return }
//        navItem.leftBarButtonItem = mergeScanButton
    }
    
    func setNavigationBarTitle(_ title: String) {
//        guard let navBar = navigationBar, let navItem = navBar.items?.first else { return }
//        navItem.title = title
    }
}
