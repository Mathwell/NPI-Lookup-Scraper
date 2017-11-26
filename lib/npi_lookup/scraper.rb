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
        :first_name =>td[3].text,
        :npi => td[0].text,
        :state => td[4].text,
        :zip => td[5].text,
        :details => doctor_css.css("td a")[0]["href"]
      }
    end
    end
    #@doctors=NpiLookup::Doctor.list
    #puts @doctors
    @doctors
  end

  def self.scrape_page(profile_url)

      html=File.read(profile_url)
      student=Nokogiri::HTML(html)
      student_css=student.css("div.main-wrapper.profile")
      twitter, linkedin, github, youtube, blog = "", "", "", "", ""
      student_css.css(".social-icon-container a").each do |social|
        if social["href"].include?("twitter")
           twitter=social["href"]
         elsif social["href"].include?("linkedin")
           linkedin=social["href"]
         elsif social["href"].include?("github")
           github=social["href"]
         elsif social["href"].include?("youtube")
           youtube=social["href"]
         else
           blog=social["href"]
         end
      end


      individual={
          :twitter => twitter,
          :linkedin => linkedin,
          :github => github,
          :blog => blog,
          :profile_quote => student.css(".profile-quote").text,
          :bio =>student.css(".bio-content p").text,
        }
        individual.delete(:twitter) if individual[:twitter]==""
        individual.delete(:linkedin) if individual[:linkedin]==""
        individual.delete(:github) if individual[:github]==""
        individual.delete(:blog) if individual[:blog]==""
        individual
      end


end
