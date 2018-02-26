//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 5/10/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: - Properties
    
    var pageHeadings = [NSLocalizedString("CREATE YOUR OWN FOOD GUIDE", comment: "CREATE YOUR OWN FOOD GUIDE"), NSLocalizedString("SHOW YOU THE LOCATION", comment: "SHOW YOU THE LOCATION"), NSLocalizedString("DISCOVER GREAT RESTAURANTS", comment: "DISCOVER GREAT RESTAURANTS")]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = [NSLocalizedString("Pin your favorite restaurants and create your own food guide", comment: "Pin your favorite restaurants and create your own food guide"),
                           NSLocalizedString("Search and locate your favourite restaurant on Maps", comment: "Search and locate your favourite restaurant on Maps"),
                           NSLocalizedString("Find restaurants shared by your friends and other foodies", comment: "Find restaurants shared by your friends and other foodies")]
    
    var currentIndex = 0
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source and delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UIPageViewControllerDataSource methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - UIPageViewControllerDelegate method
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                print("Content view controller index: \(contentViewController.index)")
                
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
            
        }
    }
    
    // MARK: - Helper methods
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }


}
