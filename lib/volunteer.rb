class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:album_id)
  end

  def self.find_by_project(pro_id)
  volunteers = []
  returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{pro_id};")
  returned_volunteers.each() do |volunteer|
    name = volunteer.fetch("name")
    id = volunteer.fetch("id").to_i
    volunteers.push(Song.new({:name => name, :project_id => pro_id, :id => id}))
  end
  volunteers
end
end
