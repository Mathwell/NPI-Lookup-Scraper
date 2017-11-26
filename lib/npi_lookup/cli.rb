#CLI controller
class NpiLookup::CLI
  def call
    display_list
    menu
    program_exit
  end

  def display_list
    puts "Welcome to NPI search (MA)"
    make_list
    #add_attributes
    NpiLookup::Doctor.all.each.with_index(1) do |doctor,index|
      puts "#{index}.#{doctor.first_name} #{doctor.last_name} #{doctor.details}"
    end
  end

  def menu
    puts "Enter doctor's name to lookup:"
    input=nil
    while input!="exit"
      input=gets.strip.downcase
      if input.to_i==0
        case input
        when "exit"
          puts "exiting..."
        when "list"
          display_list
        else
          puts "not sure what would you like to do..."
        end
      else
        index=input.to_i-1
        puts "More info about doctor #{NpiLookup::Doctor.all[index].last_name}"
        puts add_attributes(NpiLookup::Doctor.all[index].details)[:mailing_address]
      end
  end
  end

  def program_exit
    puts "Thank you for using out NPI search!"
  end

  def make_list
    doctors_array = NpiLookup::Scraper.scrape_index_page
    NpiLookup::Doctor.create_from_list(doctors_array)
  end

  def add_attributes (url)
    #NpiLookup::Doctor.all.each do |doctor|
    #puts url.to_s

    attributes = NpiLookup::Scraper.scrape_profile_page(url)
      #student.add_student_attributes(attributes)
    #end
  end

end
