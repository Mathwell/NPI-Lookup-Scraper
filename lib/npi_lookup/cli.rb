#CLI controller
class NpiLookup::CLI
  def call
    display_list
    menu
    program_exit
  end

  def display_list
    puts "Welcome to NPI search (MA)"
    @doctors=make_list
    #@doctors=NpiLookup::Doctor.list
    @doctors.each.with_index(1) do |doctor,index|
      puts "#{index}.#{doctor.first_name} #{doctor.last_name}"
    end
  end

  def menu
    puts "Enter doctor's name to lookup:"
    input=nil
    while input!="exit"
    input=gets.strip.downcase
    case input
    when "1"
      puts "Doctor 1"
    when "2"
      puts "Doctor 2"
    when "exit"
      puts "exiting..."
    when "list"
      display_list
    else
      puts "not sure what would you like to do..."
    end
  end
  end

  def program_exit
    puts "Thank you for using out NPI search!"
  end

  def make_list
    doctors_array = NpiLookup::Scraper.scrape_index_page
  end
end
