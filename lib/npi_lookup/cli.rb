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
    puts "====================================================================================================================================================="
    puts "  #   |     First Name       |             Last Name                          |                  Details"
    puts "====================================================================================================================================================="
    NpiLookup::Doctor.all.each.with_index(1) do |doctor,index|

      puts "#{index.to_s.rjust(5)} | #{doctor.first_name.rjust(20)} | #{doctor.last_name.rjust(45)[0..44]}  |  #{doctor.details}"
    end

    #NpiLookup::Doctor.all.each.with_index(1) do |doctor,index|
    #  puts "#{index}.#{doctor.first_name} #{doctor.last_name} #{doctor.details}"
    #end
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
    doctors=NpiLookup::Doctor.find_by_name(input)
    if !doctors.empty?
      puts "====================================================================================================================================================="
      puts "  #   |     First Name       |             Last Name                          |                  Business Address"
      puts "====================================================================================================================================================="

      doctors.each{|index|
        doctor=NpiLookup::Doctor.all[index]
        attridutes=add_attributes(NpiLookup::Doctor.all[index].details)
        puts "#{index.to_s.rjust(5)} | #{doctor.first_name.rjust(20)} | #{doctor.last_name.rjust(45)[0..44]}  | #{attridutes[:mailing_address]}"
        #display_detais(doctor+1)
       }
        puts "====================================================================================================================================================="
    else
      puts "Error: No doctor found."
    end

  end

  def display_detais(input)
    index=input.to_i-1
    if index<NpiLookup::Doctor.all.length
        doctor=NpiLookup::Doctor.all[index]
        attridutes=add_attributes(NpiLookup::Doctor.all[index].details)
        puts "More info about doctor #{doctor.last_name}"
        puts "====================================================================================================================================================="
        puts "  #   |     First Name       |             Last Name                          |                  Business Address"
        puts "====================================================================================================================================================="
        puts "#{input.to_s.rjust(5)} | #{doctor.first_name.rjust(20)} | #{doctor.last_name.rjust(45)[0..44]}  | #{attridutes[:mailing_address]}"
        puts "====================================================================================================================================================="
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
