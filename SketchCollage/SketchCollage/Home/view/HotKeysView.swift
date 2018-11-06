//
//  HotKeysView.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/31.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class HotKeysView: UIView {
    
    var viewController = HotKeysViewController()
    let KHotKeysCell = "HotKeysCell"
    var tableView: UITableView!
    var dataList = [HotKeysModel]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTable()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTable() {
        tableView = UITableView.init(frame: self.frame, style: .grouped)
        self.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: SWSize.navBarHeight + SWSize.tabBarHeight, right: 0)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            if SWSize.navBarHeight == 88 {
                tableView.contentInset = UIEdgeInsets(top: 140, left: 0, bottom: 0, right: 0)
            }
            else {
                tableView.contentInset = UIEdgeInsets(top: SWSize.navBarHeight + 20, left: 0, bottom: 0, right: 0)
            }
        } else {}
        let arrayM = [KHotKeysCell]
        for str in arrayM {
            self.tableView!.register(UINib(nibName:str, bundle:nil), forCellReuseIdentifier:str)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension HotKeysView: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataList.isEmpty {
            return 0
        }
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataList.isEmpty { return UITableViewCell.init() }
        let cell :HotKeysCell = tableView.dequeueReusableCell(withIdentifier: KHotKeysCell, for: indexPath) as! HotKeysCell
        let model: HotKeysModel = dataList[indexPath.section]
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension HotKeysView: SWViewProtocol {
    func showView(data: SWSucceedParamsStruct<Any>) {
//        print("HotKeysViewData ==== \(data)")
        self.dataList = data.array as! [HotKeysModel]
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
}
