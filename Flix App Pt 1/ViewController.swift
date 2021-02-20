//
//  ViewController.swift
//  Flix App Pt 1
//
//  Created by Ayon Paul on 2/13/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synoposis = movie["overview"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        cell.posterView.af.setImage(withURL: posterURL!)
        cell.titleLabel.text = title
        cell.synopsisView.text = synoposis
        return cell
    }
    //Used for the navigation section-- sends info of all the movies to the next screen/view controller to be used for blurbs of the given movies in the given indexes in the api dictionary
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        //Making a view controller object that inherits MoviesDetailsViewController so that we could send movies to the second screen
        let detailsViewController = segue.destination as! MovieDetailsViewController
        //Sends the movie in the given row indicated by indexPath by retrieving the movie in the given indexPath.row in the movies dictionary
        detailsViewController.movie = movie
        //Deselecting to clean up how a row remains clicked when we return to it from the second screen
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

