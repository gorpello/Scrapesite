import Foundation
import ArgumentParser
import ShellOut

struct Scrapesite: ParsableCommand {
    
    @Argument(help: "The url of the website to scrape.")
    var url: String
    
    @Option(help: "The desire destination path.")
    var path: String? = nil
    
    
    /*
     
     wget -m -p -E -k -K -np http://site/path/
     wget -p -k http://ExampleSite.com
     wget -k -K  -E -r -l 10 -p -N -F --restrict-file-names=windows -nH http://website.com/
     
     */
    mutating func run() throws {
        do {
            
            let commands = [
                "wget -m -p -E -k -K -np \(url)",
                "wget -p -k \(url)",
                "wget -k -K  -E -r -l 10 -p -N -F --restrict-file-names=windows -nH \(url)",
            ]
            
            let output: String
            
            if let path {
                output = try shellOut(to: commands, at: path)
            } else {
                output = try shellOut(to: commands)
            }
            
            print(output)
            print("✅ Done")
        } catch {
            print("⛔️ Error")
            let error = error as! ShellOutError
            print(error.message) // Prints STDERR
            print(error.output) // Prints STDOUT
        }
    }
    
    
}

Scrapesite.main()
