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


  def self.find_by_name(name)
    return @@all.each_with_index.map{|doctor,index| doctor.last_name.downcase.include?(name) ? index : nil}.compact
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
