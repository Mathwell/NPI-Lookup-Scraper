require 'open-uri'
require 'pry'

class NpiLookup::Scraper
  attr_accessor :doctors

  @doctors=[]

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#method is responsible for scraping the index page that lists all of the students
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  def self.scrape_index_page(index_url='http://www.npinumberlookup.org/')
    #tml=File.read(index_url)

    #doctors=Nokogiri::HTML(html)
    #students.css(".student-card").each do |student_css|

    #  @students<<{
    #    :name => student_css.css(".student-name").text,
    #    :location =>student_css.css(".student-location").text,
    #    :profile_url => student_css.css("a")[0]["href"]
    #  }
    #end
    @doctors=NpiLookup::Doctor.list
    @doctors
  end
end
