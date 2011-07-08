require 'sinatra'
require 'net/http'
require 'rubygems'
require 'xmlsimple'
require 'haml'
require 'roauth'
require 'nestful'

class RetrieveData
  
  def RetrieveTubeTop
    youtubefeedurl = 'http://gdata.youtube.com/feeds/api/standardfeeds/top_rated?time=today&max-results=10'
    uri = URI.parse(youtubefeedurl)
    File.open("file1.xml", "w+") do |f1|
      Net::HTTP.start(uri.host, uri.port) do  |http|
        f1.puts(http.get(uri.path))
      end
    end   
    youtubefeed = XmlSimple.xml_in("file1.xml", {'KeyAttr' => 'name'})
    titles = Array.new
    (0..24).each do |i|
      titles.push(youtubefeed ['entry'][i]['title'][0]['content'])
    end
    return titles
  end
  
  def RetrieveTwitterTrends
    uri = 'http://api.twitter.com/1/trends/44418.xml'
    oauth = {
        :consumer_key     => "dVpjnhvoYrtjAldtQ4Mw",
        :consumer_secret  => "btuUSqkdIzxPVUJHe7O8bOMUQ4paeZn7grhZfO7zE",
        :access_key       => "51006340-NuwlHabrTJTdLXyyVCokFbwCKMINIZxklffH6DHBM",
        :access_secret    => "ujn7X3ZZmZ4gphk9kgUMybhTZPdGWpveweQTwzwedBw"
    }
    params = {
        'count' => "11",
        'since_id' => "5000"
    }
    oauth_header = ROAuth.header(oauth, uri, params)
    File.open("file2.xml", "w+") do |f2|
      f2.puts(Nestful.get(uri, :params => params, :headers => {'Authorization' => oauth_header}))
    end
    twitterfeed = XmlSimple.xml_in("file2.xml", {'KeyAttr' => 'name'})
    trends = Array.new
    trends.push(twitterfeed ['trends'][4][1])
    
  end
  

end

 get '/' do
    data = RetrieveData.new
    @youtube_toprated = data.RetrieveTubeTop
    @twitter_trends = data.RetrieveTwitterTrends  
    
    haml :index
 end

  


