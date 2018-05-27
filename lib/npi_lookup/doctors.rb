class NpiLookup::Doctor
  attr_accessor :last_name, :first_name, :npi, :state, :zip, :details

  @@all=[]

  def initialize(doctor_hash)
    @last_name=doctor_hash[:last_name]
    @first_name=doctor_hash[:first_name]
    @npi=doctor_hash[:npi]
    @state=doctor_hash[:state]
    @zip=doctor_hash[:zip]
    @details=doctor_hash[:details]
    @@all<<self
    self
  end

  #def self.list
    #puts <<-DOC.gsub /^s*/,''
    #1. Doctor 1
    #2. Doctor 2
    #DOC

  #  doctor_1=self.new
  #  doctor_1.last_name="Doctor "
  #  doctor_1.first_name="1"
  #  doctor_1.npi="11111111111"
  #  doctor_1.state="MA"
  #  doctor_1.zip="01730"
  #  doctor_1.details="..."

  #  doctor_2=self.new
  #  doctor_2.last_name="Doctor "
  #  doctor_2.first_name="2"
  #  doctor_2.npi="22222222222"
  #  doctor_2.state="MA"
  #  doctor_2.zip="02417"
  #  doctor_2.details="..."

  #  [doctor_1, doctor_2]
  #end

  def self.find_by_name(name)
    #binding.pry
    return @@all.each_with_index.map{|doctor,index| doctor.last_name.downcase.include?(name) ? index : nil}
    #return @@all.select{|doctor| doctor.last_name.downcase.include?(name)}
  end

  def self.create_from_list(doctors_array)
    doctors_array.each do |doctor|
      self.new(doctor)
    end
  end

def self.all
  @@all
end

end
