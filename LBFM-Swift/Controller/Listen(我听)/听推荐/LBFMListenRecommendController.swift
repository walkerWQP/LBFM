//
//  LBFMListenRecommendController.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/22.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMListenRecommendController: UIViewController,LTTableViewProtocal {
    private let LBFMListenRecommendCellID = "LBFMListenRecommendCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight - LBFMTabBarHeight - LBFMNavBarHeight), self, self, nil)
        tableView.register(LBFMListenRecommendCell.self, forCellReuseIdentifier: LBFMListenRecommendCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        // tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    lazy var viewModel: LBFMListenRecommendViewModel = {
        return LBFMListenRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // 加载数据
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
}

extension LBFMListenRecommendController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LBFMListenRecommendCell = tableView.dequeueReusableCell(withIdentifier: LBFMListenRecommendCellID, for: indexPath) as! LBFMListenRecommendCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.albums = viewModel.albums?[indexPath.row]
        return cell
    }
}
