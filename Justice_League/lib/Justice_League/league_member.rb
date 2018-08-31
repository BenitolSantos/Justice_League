class JusticeLeague::League_Member
  attr_accessor :name, :alias, :profile_url, :alignment, :identity, :race, :citizenship, :marital_status, :occupation

  @@current_members = []

  def initialize(league_hash)
    @name = league_hash[:name]
    @alias = league_hash[:alias]
    @profile_url = league_hash[:profile_url]
    @@current_members << self
  end

  def self.find_by_name(name)
    @@current_members.find {|member| member.name.downcase == name} #fixed using find instead of iterating
  end

  def self.create_from_collection(league_array)
    #problem was that it was hashes within a nested array.
    #an array of arrays filled with hashes, repeating.
    league_array.first.each do |league_hash|
      self.new(league_hash)
    end
  end

  def add_member_attributes(attributes_hash)
    @alignment = attributes_hash[:alignment]
    @identity = attributes_hash[:identity]
    @race = attributes_hash[:race]
    @citizenship = attributes_hash[:citizenship]
    @marital_status = attributes_hash[:marital_status]
    @occupation = attributes_hash[:occupation]
  end

  def remove_league_member
    @@current_members.delete_if{|i| i == self }
  end

  def self.current_members
    @@current_members
  end
end
