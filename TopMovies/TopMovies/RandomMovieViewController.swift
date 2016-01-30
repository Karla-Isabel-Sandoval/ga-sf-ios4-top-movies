import UIKit

class RandomMovieViewController: UIViewController {
    
    //
    // Put IBOutlets Below This Line
    //
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet var movieLabel: UILabel!
    
    //
    // Put IBOutlets Above This Line
    //
    
    var movies: [NSDictionary]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.title = "🔝🎞"
        
        let itunesURL = NSURL(string: "https://itunes.apple.com/us/rss/topmovies/limit=100/json")!
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: itunesURL)) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let moviesArray = json.valueForKeyPath("feed.entry") as? [NSDictionary]
                self.movies = moviesArray
                print("Yay! The Movies Downloaded! 🎉")
                print("json:\(json)")
                self.movieLabel.text = self.titleStringForMovieAtIndex(1)
            }
        }.resume()

    }
    
    //
    // Put IBAction Below This Line
    //
    
    
    
    //
    // Put IBAction Above This Line
    //
    
    func titleStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let title = movie?.valueForKeyPath("im:name.label") as? String
        return title
    }
    
    func directorStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let director = movie?.valueForKeyPath("im:artist.label") as? String
        return director
    }
    
    func summaryStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let summary = movie?.valueForKeyPath("summary.label") as? String
        return summary
    }
    
    func posterImageURLForMovieAtIndex(index: Int) -> NSURL {
        let movie = self.movies?[index]
        let posterImageURLArray = movie?.valueForKeyPath("im:image.label") as? [String]
        let posterImageURLString = posterImageURLArray?.last
        let posterImageURL = NSURL(string: posterImageURLString!)!
        return posterImageURL
    }
    
    func randomIntegerWithMinimum(min: Int, andMaximum max: Int) -> Int {
        let randomNumber = Int(arc4random_uniform(UInt32((max - min) + 1))) + min
        return randomNumber
    }
}
