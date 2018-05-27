#CLI controller
class NpiLookup::CLI
  def call
    make_list
    puts "Welcome to NPI search (MA)"
    display_list
    menu
    program_exit
  end

  def display_list
    NpiLookup::Doctor.all.each.with_index(1) do |doctor,index|
      puts "#{index}.#{doctor.first_name} #{doctor.last_name} #{doctor.details}"
    end
  end

  def menu

    input=nil
    while input!="exit"
        puts "Enter doctor's name/number to lookup, list to display a list, exit to exit seach:"
      input=gets.strip.downcase
      if input.to_i==0
        case input
        when "exit"
          puts "exiting..."
        when "list"
          display_list
        else
          display_detais_by_name(input)
        end
      else
        display_detais(input)
      end
  end
  end

  def display_detais_by_name(input)
    puts "#{input}"
  end

  def display_detais(input)
    index=input.to_i-1
    if index<NpiLookup::Doctor.all.length
        puts "More info about doctor #{NpiLookup::Doctor.all[index].last_name}"
        puts add_attributes(NpiLookup::Doctor.all[index].details)[:mailing_address]
      else
        puts "Error: #{input} does not exit in the database"
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
