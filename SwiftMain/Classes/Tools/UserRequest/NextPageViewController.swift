//
//  TableViewController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/16.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

extension UITableView: ReloadableType {}
extension UICollectionView: ReloadableType {}


extension NextPageLoadable
{
    func loadNext(view: ReloadableType) {
        guard nextPageState.hasNext else { return }
        if nextPageState.isLoading { return }
        
        nextPageState.isLoading = true
        performLoad(successHander: { (rows, hasNext, lastId) in
            self.data += rows
            self.nextPageState.update(hasNext: hasNext, isLoading: false, lastId: lastId)
            view.reloadData()
        }, failHandler: {
            //..
        })
    }
}

extension NextPageLoadable where Self: UITableViewController
{
    func loadNext() {
        loadNext(view: tableView)
    }
}

extension NextPageLoadable where Self: UICollectionViewController
{
    func loadNext() {
        loadNext(view: collectionView)
    }
}



class FriendTableViewController: UITableViewController
{
    var nextPageState = NextPageState<Int>()
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNext()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            loadNext()
        }
    }
}
extension FriendTableViewController: NextPageLoadable
{
    
    
    func performLoad(successHander: ([String], Bool, FriendTableViewController.LastIdType?) -> (), failHandler: () -> ()) {
        //进行网络请求
//        NetworkTool.loadHomeNewsTitleData { (titles) in
//            successHander(titles,hasNext,lastId)
//        }
    }
}
