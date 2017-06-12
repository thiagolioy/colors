//
//  ListViewControllerSpec.swift
//  Colors
//
//  Created by Thiago Lioy on 12/06/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Colors

class ListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("should test the view controller") {
            var sut: ListViewController!
            
            beforeEach {
                sut = ListViewController.fromStoryboard()
                _ = sut.view
            }
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            it("should have expected number of rows") {
                let count = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
                expect(count).to(equal(5))
            }
            
            
            describe("cellForRow") {
                
                var cell: UITableViewCell!
                
                beforeEach {
                    let indexPath = IndexPath(item: 0, section: 0)
                    cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
                }
                
                it("should have a valid cell") {
                    expect(cell).toNot(beNil())
                }
                it("should have expected cell type") {
                    expect(cell).to(beAKindOf(ColorCell.self))
                }
                
                it("should have a cell configured as expected") {
                    let colorCell = cell as! ColorCell
                    expect(colorCell.colorLabel.text).to(equal("Red"))
                    expect(colorCell.colorContainer.backgroundColor)
                        .to(equal(UIColor.red))
                }
            }
            
           
        }
    }
}
