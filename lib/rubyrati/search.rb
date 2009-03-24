require 'rubyrati'

module Rubyrati
  class Search < Base
    
    def initialize(query)
      @query = query
    end
    
    def get_results(key, *args)
      path = "search"
      puts args
      res = fetch(path, key, {:query => @query, :authority => 'a7', :language => 'en'})
      parsed_response = {
        :results => res.search("//item").collect{|i| resultify_posts(i)}
      }
    end
    
    private
    
    def resultify_posts(e)
      {
        :name => e.get_html("//weblog/name"),
        :url => e.get_html("//weblog/url"),
        :rssurl => e.get_html("//weblog/rssurl"),
        :atomurl => e.get_html("//weblog/atomurl"),
        :inbound_blogs => e.get_html("//weblog/inboundblogs").to_i,
        :inbound_links => e.get_html("//weblog/inboundlinks").to_i,
        :last_update => e.get_html("//weblog/lastupdate").tr_time_to_datetime,
        :title => e.get_html("//title"),
        :excerpt => e.get_text("//excerpt"),
        :created => e.get_html("//created"),
        :permalink => e.get_html("//permalink")
      }
    end
  end
end