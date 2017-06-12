//
//  ViewControllerSpec.swift
//  Colors
//
//  Created by Thiago Lioy on 07/06/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Colors

//Ter uma forma de controlar a implementacao do navigationController
class FakeNavigationController: UINavigationController {
    
    var didCallPush = false
    var controllersInStack: [UIViewController] = []
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        controllersInStack.append(viewController)
        didCallPush = true
    }
}

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("should test the view controller") {
            var sut: ViewController!
            
            beforeEach {
                sut = ViewController.fromStoryboard()
                _ = sut.view
            }
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            describe("should have expected view elements"){
                it("should have a valid color container view") {
                    expect(sut.colorContainer).toNot(beNil())
                }
                
                it("should have a valid color label") {
                    expect(sut.colorLabel).toNot(beNil())
                }
                
                it("should have a valid next button") {
                    expect(sut.nextButton).toNot(beNil())
                }
                
                it("should have a valid previous button") {
                    expect(sut.previousButton).toNot(beNil())
                }
                
                it("should have a valid page control") {
                    expect(sut.pageControl).toNot(beNil())
                }
                
            }
            
            describe("should have expected UI State Configured") {
                it("should have red as first background color") {
                    expect(sut.colorContainer.backgroundColor).to(equal(UIColor.red))
                }
                it("should have red as first color label") {
                    expect(sut.colorLabel.text).to(equal("Red"))
                }
                
                it("should have expected number of pages") {
                    expect(sut.pageControl.numberOfPages).to(equal(2))
                }
            }
            
            describe("should be able to go to next color") {
                
                beforeEach {
                    sut.currentPage = 0
                    sut.next()
                }
                
                it("should have expected currentPage inside page control") {
                    expect(sut.pageControl.currentPage).to(equal(1))
                }
                
                it("should have incresed currentPage") {
                    expect(sut.currentPage).to(equal(1))
                }
                
                it("should not increse currentPage after limit") {
                    sut.next()
                    sut.next()
                    sut.next()
                    expect(sut.currentPage).to(equal(1))
                }
            }
            
            describe("should be able to go to previous color") {
                
                beforeEach {
                    sut.currentPage = 1
                    sut.previous()
                }
                
                it("should have expected currentPage inside page control") {
                    expect(sut.pageControl.currentPage).to(equal(0))
                }
                
                it("should have incresed currentPage") {
                    expect(sut.currentPage).to(equal(0))
                }
                it("should not decrease currentPage after limit") {
                    sut.previous()
                    sut.previous()
                    expect(sut.currentPage).to(equal(0))
                }
            }
            
            describe("setColor for page") {
                context("valid pages") {
                    it("should have red as first color") {
                        sut.currentPage = 0
                        expect(sut.colorContainer.backgroundColor)
                            .to(equal(UIColor.red))
                        expect(sut.colorLabel.text).to(equal("Red"))
                    }
                    
                    it("should have red as second color") {
                        sut.currentPage = 1
                        expect(sut.colorContainer.backgroundColor)
                            .to(equal(UIColor.blue))
                        expect(sut.colorLabel.text).to(equal("Blue"))
                    }
                }
                
                context("invalid pages") {
                    
                    beforeEach {
                        sut.currentPage = 0
                    }
                    
                    
                    
                    it("should have same color page") {
                        sut.setColor(forPage:-1)
                        expect(sut.currentPage).to(equal(0))
                        sut.setColor(forPage:3)
                        expect(sut.currentPage).to(equal(0))
                    }
                }
                
            }
            
            
            
            describe("proceedToListController") {
                
                var navigation: FakeNavigationController!
                
                beforeEach {
                    navigation = FakeNavigationController(rootViewController: sut)
                    navigation.didCallPush = false
                }
                
                it("should have a navigation controller") {
                    expect(sut.navigationController).toNot(beNil())
                }
                
                it("should have a expected count of controllers in stack") {
                    let controllerInStack = navigation.viewControllers.count
                    expect(controllerInStack).to(equal(1))
                }
                
                it("should have expected value for didCallPush") {
                    expect(navigation.didCallPush).to(beFalse())
                }
                
                it("should have called didCallPush after navigation") {
                    sut.proceedToColorsList()
                    expect(navigation.didCallPush).to(beTrue())
                }
                
                it("should have expected controllers in stack") {
                    let controllers = navigation.controllersInStack
                    expect(controllers.count).to(equal(1))
                }
                
                it("should have expected controllers in stack after proceedToColorsList") {
                    sut.proceedToColorsList()
                    let controllers = navigation.controllersInStack
                    expect(controllers.count).to(equal(2))
                    expect(controllers.last!).to(beAKindOf(ListViewController.self))
                }
            }
            
            
            
            
            
        }
    }
}
