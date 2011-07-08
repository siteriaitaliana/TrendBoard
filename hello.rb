require 'sinatra'
require 'net/http'
require 'rubygems'
require 'xmlsimple'
require 'haml'
require "roauth"
require "nestful"

class RetrieveData
  
  def RetrieveTubeTop
    youtubefeedurl = 'http://gdata.youtube.com/feeds/api/standardfeeds/top_rated?time=today&max-results=10'
    uri = URI.parse(youtubefeedurl)
    File.open("file1.xml", "w+") do |f1|
      Net::HTTP.start(uri.host, uri.port) do  |http|
        f1.puts(http.get(uri.path))
      end
    end   
    feed = XmlSimple.xml_in("file1.xml", {'KeyAttr' => 'name'})
    titles = Array.new
    (0..24).each do |i|
      titles.push((feed['entry'][i]['title'][0]['content']))
    end
    return titles
  end
  
  def RetrieveTwitterTrends
    url = "https://twitter.com/direct_messages.json"
    oauth = {
      :consumer_key    => "consumer_key",
      :consumer_secret => "consumer_secret",
      :access_key      => "access_key",
      :access_secret   => "access_secret"
    }
    params = {
      :count    => "11",
      :since_id => "5000"
    }
    oauth_header = ROAuth.header(oauth, url, params)
    Nestful.get(url, :params => params, :headers => {'Authorization' => oauth_header})
  end
  
end

 get '/' do
    data = RetrieveData.new
    @youtube_toprated = data.RetrieveTubeTop 
    
    haml :index
 end

  


