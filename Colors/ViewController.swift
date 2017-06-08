//
//  ViewController.swift
//  Colors
//
//  Created by Thiago Lioy on 07/06/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

struct Color {
    let name: String
    let color: UIColor
}

class ViewController: UIViewController {

    @IBOutlet weak var colorContainer: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let colors: [Color] = [
        Color(name: "Red", color: UIColor.red),
        Color(name: "Blue", color: UIColor.blue)
    ]
    
    var currentPage: Int = 0 {
        didSet{
            pageControl.currentPage = currentPage
            setColor(forPage: currentPage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUIState()
    }
    
    func setupInitialUIState() {
        guard let firstColor = colors.first else {
            fatalError("should have an initial color")
        }
        pageControl.numberOfPages = colors.count
        pageControl.currentPage = 0
        setupUI(with: firstColor)
    }
    
    func setupUI(with color: Color) {
        colorContainer.backgroundColor = color.color
        colorLabel.text = color.name
    }
    
    func setColor(forPage page: Int) {
        if page < 0 || page >= colors.count {
            return
        }
        let color = colors[page]
        setupUI(with: color)
    }
    
    func updatePage(page: Int) {
        if page < 0 || page >= colors.count {
            return
        }
        currentPage = page
    }
    
    @IBAction func previous() {
        updatePage(page: currentPage - 1)
    }
    
    @IBAction func next() {
        updatePage(page: currentPage + 1)
    }
}

extension ViewController {
    static func fromStoryboard() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
}

