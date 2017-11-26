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

  def self.scrape_profile_page(profile_url)

      #html=File.read(profile_url)
      doctor=Nokogiri::HTML(open(profile_url))
      #doctor_css=student.css("table tr")
      attributes=doctor.css("table tr")
        individual={
        :gender =>attributes[3].css("td")[2].text,
        :provider_license =>attributes[4].css("td")[2].text,
        :entity =>attributes[8].css("td")[2].text,
        :last_update =>attributes[10].css("td")[2].text,
        :mailing_address =>attributes[13].css("td")[2].text,
        :m_phone =>attributes[14].css("td")[2].text,
        :m_fax =>attributes[15].css("td")[2].text,
        :business_address =>attributes[18].css("td")[2].text,
        :b_phone =>attributes[19].css("td")[2].text,
        :b_fax =>attributes[20].css("td")[2].text,
        :primary_taxonomy => attributes[23].css("td")[2].text,
        :secondary_taxonomy => attributes[24].css("td")[2].text,
      }

       individual
      end


end
