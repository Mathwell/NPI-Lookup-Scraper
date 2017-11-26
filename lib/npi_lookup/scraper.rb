require 'open-uri'
require 'pry'

class NpiLookup::Scraper
  attr_accessor :doctors

  @doctors=[]

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#method is responsible for scraping the index page that lists all of the students
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  def self.scrape_index_page(index_url='http://www.npinumberlookup.org/getResults.php')
    #html=File.read(index_url)

    doctors=Nokogiri::HTML(open(index_url))
    #puts doctors
    #puts doctors.css("table tr")[0].text
    doctors.css("table tr").each_with_index do |doctor_css, i|
      if i>0
        td=doctor_css.css("td")
      @doctors<<{
        :last_name => td[1].text,
        :first_name =>td[2].text,
        :npi => td[0].text,
        :state => td[4].text,
        :zip => td[5].text,
        :details => td[6]["href"]
      }
    end
    end
    #@doctors=NpiLookup::Doctor.list
    #puts @doctors
    @doctors
  end
end
