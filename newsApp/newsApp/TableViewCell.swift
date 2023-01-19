//
//  TableViewCell.swift
//  newsApp
//
//  Created by Cubastion on 19/01/23.
//

import UIKit
import SafariServices

class newsCellViewModel {
    let title : String?
    let subtitle : String?
    let imageURL : URL?
    var imageData : Data? = nil
    
    init(title : String?, subtitle : String?, imageURL : URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSubtitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsSubtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: newsCellViewModel){
        newsTitleLabel.text = viewModel.title!
        newsSubtitleLabel.text = viewModel.subtitle!
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, error == nil else {
                    return
                }
                
                viewModel.imageData = data
                
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
