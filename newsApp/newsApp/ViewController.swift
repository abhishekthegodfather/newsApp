//
//  ViewController.swift
//  newsApp
//
//  Created by Cubastion on 19/01/23.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    
    var viewModel = [newsCellViewModel]()
    var articles = [Article]()
    
    var tableView : UITableView = {
        let table = UITableView()
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        table.register(cellNib, forCellReuseIdentifier: TableViewCell.id)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        title = "News"
        fetchtopseries()
    }
    
    func fetchtopseries(){
        apiCaller.shared.apiCallerThing { (result) in
            switch result {
            case .success(let articles):
                self.articles = articles
                self.viewModel = articles.compactMap({
                    newsCellViewModel(title: $0.title ?? "No title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        cell.newsTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cell.newsSubtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        cell.imageView?.layer.cornerRadius = 6
        cell.imageView?.clipsToBounds = true
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

