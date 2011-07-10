require 'rubygems'
require 'sinatra'
require 'http-request'
require 'xmlsimple'
require 'haml'
require 'roauth'
require 'nestful'
require 'json'
require 'uri'
require 'i18n'

class RetrieveData 
  
  def RetrieveTubeTop 
    youtubefeedurl = 'http://gdata.youtube.com/feeds/api/standardfeeds/top_rated?time=today&max-results=10'
    uri = URI.parse(youtubefeedurl)
    File.open("file1.xml", "w+") do |f|
      Net::HTTP.start(uri.host, uri.port) do  |http|
        f.puts(http.get(uri.path))
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
    trendsuri = 'http://api.twitter.com/1/trends/44418.json'
    oauth = {
        :consumer_key     => "dVpjnhvoYrtjAldtQ4Mw",
        :consumer_secret  => "btuUSqkdIzxPVUJHe7O8bOMUQ4paeZn7grhZfO7zE",
        :access_key       => "51006340-NuwlHabrTJTdLXyyVCokFbwCKMINIZxklffH6DHBM",
        :access_secret    => "ujn7X3ZZmZ4gphk9kgUMybhTZPdGWpveweQTwzwedBw"
    }
    params = {
        'count' => "10",
        'since_id' => "5000"
    }
    oauth_header_trends = ROAuth.header(oauth, trendsuri, params)
    trends = Nestful.get(trendsuri, :params => params, :headers => {'Authorization' => oauth_header_trends})
    trend = JSON.parse(trends)
    trendquery = Array.new()
    trendquery.push(trend[0]['trends'][0]['name'])
    trendquery.push(trend[0]['trends'][1]['name'])
    trendquery.push(trend[0]['trends'][2]['name'])
    trendquery.push(trend[0]['trends'][3]['name'])
    trendquery.push(trend[0]['trends'][4]['name'])
    trendquery.push(trend[0]['trends'][5]['name'])
    trendquery.push(trend[0]['trends'][6]['name'])
    trendquery.push(trend[0]['trends'][7]['name'])
    trendquery.push(trend[0]['trends'][8]['name'])
    trendquery.push(trend[0]['trends'][9]['name'])
    
  end
  
  def RetrieveTwitts
    lasttweets = 'http://api.twitter.com/1/statuses/public_timeline.json'
    oauth = {
        :consumer_key     => "dVpjnhvoYrtjAldtQ4Mw",
        :consumer_secret  => "btuUSqkdIzxPVUJHe7O8bOMUQ4paeZn7grhZfO7zE",
        :access_key       => "51006340-NuwlHabrTJTdLXyyVCokFbwCKMINIZxklffH6DHBM",
        :access_secret    => "ujn7X3ZZmZ4gphk9kgUMybhTZPdGWpveweQTwzwedBw"
    }
    params = {
        'count' => "10",
        'since_id' => "5000"
    }
    
    oauth_header_tweets = ROAuth.header(oauth, lasttweets, params)
    tweets = Nestful.get(lasttweets, :params => params, :headers => {'Authorization' => oauth_header_tweets})
    tweet = JSON.parse(tweets)
    tweetquery = Array.new(10)
    tweetquery.push(tweet[0]['text']) 
    tweetquery.push(tweet[1]['text']) 
    tweetquery.push(tweet[2]['text']) 
    tweetquery.push(tweet[3]['text']) 
    tweetquery.push(tweet[4]['text']) 
    tweetquery.push(tweet[5]['text']) 
    tweetquery.push(tweet[6]['text']) 
    tweetquery.push(tweet[7]['text']) 
    tweetquery.push(tweet[8]['text']) 
    tweetquery.push(tweet[9]['text'])  
    
  end
  
  def RetrieveGoogleTrends
    lasttweets = 'http://www.google.com/trends/hottrends/atom/hourly'
    
    uri = URI.parse(lasttweets)
    File.open("file2.xml", "w+") do |f|
      Net::HTTP.start(uri.host, uri.port) do  |http|
        f.puts(http.get(uri.path))
      end
    end   
    googletrends = XmlSimple.xml_in("file2.xml", {'KeyAttr' => 'name'})
    gtrends = Array.new
    gtrends.push(googletrends)
    return gtrends
  end
  
  def RetrieveGuardianLatest
    lastnews = 'http://content.guardianapis.com/search?format=json'
    uri = URI.parse(lastnews)
    newsfeed = Net::HTTP.get(uri)
    news = JSON.parse(newsfeed)
    newsquery = Array.new(10)
    newsquery.push(news['response']['results'][0]['webTitle']+"\n")
    newsquery.push(news['response']['results'][1]['webTitle'])
    newsquery.push(news['response']['results'][2]['webTitle'])
    newsquery.push(news['response']['results'][3]['webTitle'])
    newsquery.push(news['response']['results'][4]['webTitle'])
    newsquery.push(news['response']['results'][5]['webTitle'])
    newsquery.push(news['response']['results'][6]['webTitle'])
    newsquery.push(news['response']['results'][7]['webTitle'])
    newsquery.push(news['response']['results'][8]['webTitle'])
    newsquery.push(news['response']['results'][9]['webTitle'])  
  end
  
  def RetrieveBBCnews
    lastbbcnews = 'http://feeds.bbci.co.uk/news/rss.xml'
    
    uri = URI.parse(lastbbcnews)
    File.open("file3.xml", "w+") do |f|
      Net::HTTP.start(uri.host, uri.port) do  |http|
        f.puts(http.get(uri.path))
      end
    end 
      
    bbcnews = XmlSimple.xml_in("file3.xml", {'KeyAttr' => 'name'})
    news = Array.new
    news.push(bbcnews['channel'][0]['item'][0]['title'])
    news.push(bbcnews['channel'][0]['item'][1]['title'])
    news.push(bbcnews['channel'][0]['item'][2]['title'])
    news.push(bbcnews['channel'][0]['item'][3]['title'])
    news.push(bbcnews['channel'][0]['item'][4]['title'])
    news.push(bbcnews['channel'][0]['item'][5]['title'])
    news.push(bbcnews['channel'][0]['item'][6]['title'])
    news.push(bbcnews['channel'][0]['item'][7]['title'])
    news.push(bbcnews['channel'][0]['item'][8]['title'])
    news.push(bbcnews['channel'][0]['item'][9]['title'])
  end
  
  
end


  get '/' do
    data = RetrieveData.new
    @youtube_toprated = data.RetrieveTubeTop
    @twitter_trends = data.RetrieveTwitterTrends
    @twitter_twitts = data.RetrieveTwitts  
    @google_trends = data.RetrieveGoogleTrends
    @guardian_news = data.RetrieveGuardianLatest
    @bbc_news = data.RetrieveBBCnews
    haml :index
 end
 
 get '/logo.png' do
  #custom logic..
  send_file "logo.png"
  end
  

 



  


