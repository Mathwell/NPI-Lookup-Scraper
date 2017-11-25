#CLI controller
class NpiLookup::CLI
  def call
    display_list
    menu
    program_exit
  end

  def display_list
    puts "Welcome to NPI search (MA)"
    @doctors=NpiLookup::Doctor.list
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
    else
      puts "not sure what would you like to do..."
    end
  end
  end

  def program_exit
    puts "Thank you for using out NPI search!"
  end
end
