//
//  SWGridView.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/24.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//


/// 格子视图使用方法：
//func setupUI() {
//    var buttons = [UIButton]()
//    for i in 0 ..< 20 {
//        let button = UIButton.init(type: .custom)
//        button.tag = i
//        buttons.append(button)
//    }
//    let gridView = HLGridView.init(frame: .zero)
//    gridView.frame = CGRect(x: 0, y: 200, width: 300, height: 0)
//    gridView.gridHeight = 80
//    gridView.column = 2
//    gridView.views = buttons
//    gridView.separatorWidth = 1
//    self.view.addSubview(gridView)
//}


import UIKit

class SWGridView: UIView {
    
    var views = [UIButton]()            // 格子的按钮数组，可获取格子的个数
    var column: Int = 0                 // 每行格子的个数
    var containerWidth: CGFloat = 0     // 格子父视图的宽度
    var separatorWidth: CGFloat = 0     // 格子的间距
    var gridHeight: CGFloat = 0         // 每个格子的高度
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.containerWidth = frame.size.width
        setupUI(views: views)
    }
    
    func setupUI(views: [UIButton]) {
        self.backgroundColor = UIColor.init(red: 225.0 / 255.0, green: 225.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
        guard column != 0 else { return }
        let gridViewCount = views.count
        let rowCount = gridViewCount / column + (gridViewCount % column > 0 ? 1 : 0)
        self.frame.size.height = CGFloat(rowCount) * gridHeight + CGFloat(rowCount-1) * separatorWidth
        let subviewWidth = floor(containerWidth - separatorWidth * CGFloat(column - 1)) / CGFloat(column)
        for item in self.subviews {
            if item.isKind(of: UIView.self) { item.removeFromSuperview() }
        }
        for row in 0 ..< views.count {
            for columnIdx in 0 ..< column {
                let index = row * column + columnIdx
                guard index < views.count else {
                    continue
                }
                let isLastColumn = columnIdx == column - 1
                let isLastRow = row == rowCount - 1
                let offset_x = CGFloat(columnIdx) * CGFloat(subviewWidth + separatorWidth)
                let offset_y = (gridHeight + separatorWidth) * CGFloat(row)
//                if index%2 == 0 {
//                    views[index].backgroundColor = .red
//                }
//                else {views[index].backgroundColor = .lightGray}
                views[index].backgroundColor = UIColor.white
                
//                views[index].action { (sender) in
////                    sender.tag = index
//                    print("====tag==== \(sender.tag)")
////                    self.delegate?.sw_grid_button_action(sender: sender)
//                }
                views[index].frame = CGRect(x: offset_x, y: offset_y, width: subviewWidth, height: gridHeight)
                
                if isLastColumn {
                    // 每行最后一个item要占满剩余空间，否则可能因为strecthColumnWidth不精确导致右边漏空白
                    let v = CGFloat(column - 1)
                    views[index].frame.size.width = self.bounds.size.width - subviewWidth * v - separatorWidth * v
                }
                if isLastRow {
                    // 最后一行的item要占满剩余空间，避免一些计算偏差
                    let h = rowCount - 1
                    views[index].frame.size.height = self.bounds.size.height - gridHeight * CGFloat(h) - separatorWidth * CGFloat(h)
                }
                self.addSubview(views[index])
            }
        }
    }
}


