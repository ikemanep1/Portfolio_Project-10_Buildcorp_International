class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(volunteer_to_compare)
    (self.name() == volunteer_to_compare.name()) && (self.project_id() == volunteer_to_compare.project_id())
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.find_by_project(pro_id)
  volunteers = []
  returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{pro_id};")
  returned_volunteers.each() do |volunteer|
    name = volunteer.fetch("name")
    id = volunteer.fetch("id").to_i
    volunteers.push(Volunteer.new({:name => name, :project_id => pro_id, :id => id}))
  end
  volunteers
end

def save
  result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
  @id = result.first().fetch("id").to_i
end
end
