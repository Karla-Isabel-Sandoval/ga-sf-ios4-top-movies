//
//  RandomMoviesTableViewController.swift
//  TopMovies
//
//  Created by Karla I. Sandoval on 1/30/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class RandomMoviesTableViewController: UITableViewController {

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
                //tell the table views to load our movies
                self.tableView.reloadData()
            }
            }.resume()
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let movieCount = self.movies?.count{
            return movieCount
        }else {
            print("No movies yet?")
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
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
        
        // Configure the cell...
        let movieTitle = titleStringForMovieAtIndex(indexPath.row)
        cell.textLabel?.text = titleStringForMovieAtIndex(indexPath.row)
        //index path is always for 1 and the row is just for a row, in this case it corresponds to a movie.
        
        let movieImageURL = posterImageURLForMovieAtIndex(indexPath.row)
        print("Image URL for movie\(movieTitle):")
        print(movieImageURL)
        
       cell.imageView!.setImageWithURL(movieImageURL)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
