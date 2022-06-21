//
//  NewsListViewController.swift
//  PlayoTask
//
//  Created by Kripa Tripathi on 21/06/22.
//

import UIKit
import SwiftyJSON

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    let refreshControl = UIRefreshControl()
    var newsDataList = [NewsModel?]()
    var urlData = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        
        let newsss  = UserDefaults.standard.object(forKey: "SavedData")
     
        if newsss == nil{
            getFacilitylist(){(newsData,err) in
                if err == nil{
                    self.newsDataList = newsData ?? []
                    self.newsTableView.reloadData()
                }
            }
        }else{
            do {
           
            let json = try JSON(data: newsss as! Data)
            if json["status"].stringValue == "ok"{
                self.newsDataList = json["articles"].arrayValue.map{ NewsModel(json: $0)}
            }
                self.newsTableView.reloadData()
            }catch {print(error.localizedDescription)}
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getFacilitylist(){(newsData,err) in
            if err == nil{
               
                UserDefaults.standard.removeObject(forKey: "SavedData")
                let newsss  = UserDefaults.standard.object(forKey: "SavedData")
                self.newsDataList.removeAll()
                self.newsDataList = newsData ?? []
                self.newsTableView.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsDetailsSegue" {
            let targetVC = segue.destination as! NewsDetailsViewController
            targetVC.urlData = self.urlData
        }
    }
}
// MARK: - Table view Delegates
extension NewsListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError("xib does not exists") }
        cell.selectionStyle = .none
        cell.populateData(data: newsDataList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dt = newsDataList[indexPath.row]
        self.urlData = dt?.url ?? ""
        self.performSegue(withIdentifier: "NewsDetailsSegue", sender: nil)
    }
}

// MARK:- Webservice methods
extension NewsListViewController {
    
    func getFacilitylist(completion: @escaping([NewsModel]?,Error?) -> ()){
        let url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=dbeed0069a4d420d9b0b82f9d9edde1d"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard  error == nil && data != nil else {
                DispatchQueue.main.async {
                    print(error?.localizedDescription ?? "")
                }
                return
            }
            DispatchQueue.main.async
            {
                guard let data = data else {
                    print("error in getting data")
                    return
                }
                do {
            
                    var bData = [NewsModel]()
                    let json = try JSON(data: data)
                    print(json)
                    if json["status"].stringValue == "ok"{
                        bData = json["articles"].arrayValue.map{ NewsModel(json: $0)}
                    }
                    guard let rawData = try? json.rawData() else { return }
                    UserDefaults.standard.setValue(rawData, forKey: "SavedData")
                    print(bData)
                    
                    completion(bData,nil)
                }catch {print(error.localizedDescription)}
            }
        }.resume()
    }
    
   
}
