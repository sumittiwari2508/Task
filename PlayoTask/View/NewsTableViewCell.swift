//
//  NewsTableViewCell.swift
//  PlayoTask
//
//  Created by Kripa Tripathi on 21/06/22.
//

import UIKit
import Kingfisher


class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateData(data: NewsModel?){
        newsTitle.text = (data?.title ?? "").uppercased()
        authorName.text = (data?.author ?? "").uppercased()
        newsDescription.text = (data?.description ?? "").uppercased()
        let used_Img = data?.urlToImage ?? ""
        let imgg = used_Img.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        newsImage.kf.setImage(with: URL(string: imgg ?? ""), placeholder: UIImage(named: "logo-3"))
     }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
