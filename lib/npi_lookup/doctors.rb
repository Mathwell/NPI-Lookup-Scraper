class NpiLookup::Doctor
  attr_accessor :last_name, :first_name, :npi, :state, :zip, :details

  def self.list
    #puts <<-DOC.gsub /^s*/,''
    #1. Doctor 1
    #2. Doctor 2
    #DOC

    doctor_1=self.new
    doctor_1.last_name="Doctor "
    doctor_1.first_name="1"
    doctor_1.npi="11111111111"
    doctor_1.state="MA"
    doctor_1.zip="01730"
    doctor_1.details="..."

    doctor_2=self.new
    doctor_2.last_name="Doctor "
    doctor_2.first_name="2"
    doctor_2.npi="22222222222"
    doctor_2.state="MA"
    doctor_2.zip="02417"
    doctor_2.details="..."

    [doctor_1, doctor_2]
  end

end
