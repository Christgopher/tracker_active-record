require("sinatra")
require("sinatra/reloader")
require "sinatra/activerecord"
require("./lib/division")
require("./lib/employee")
require("./lib/project")

also_reload("lib/**/*.rb")
require("pg")

get("/") do
  @divisions = Division.all()
  @projects = Project.all()
  erb(:index)
end

post("/divisions") do
  name = params.fetch("name")
  division = Division.create({name: name})
  @divisions = Division.all()
  @projects = Project.all()
  erb(:index)
end

get("/division/:id") do
  @division = Division.find(params.fetch("id").to_i())
  erb(:division)
end



delete("/division/:id/edit") do
  @division = Division.find(params.fetch("id").to_i())
  @division.delete()
  @divisions = Division.all()
  @projects = Project.all()
  erb(:index)
end

patch("/division/:id/edit") do
  @division = Division.find(params.fetch("id").to_i())
  name = params.fetch("name")
  @division.update({name: name})
  erb(:division)
end


post("/projects") do
  name = params.fetch("name")
  project = Project.create({name: name})
  @divisions = Division.all()
  @projects = Project.all()
  erb(:index)
end

get("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @employees = Employee.all()
  erb(:project)
end

get("/employee/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  @projects = Project.all()
  erb(:employee)
end

post("/employees") do
  id = params.fetch("division_id").to_i()
  @division = Division.find(id)
  name = params.fetch("name")
  employee = Employee.create({name: name, division_id: @division.id})
  @employees = Employee.all()
  erb(:division)
end

post("/employee/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  @project = Project.find(params.fetch("project_id").to_i())
  project_id = @project.id()
  @employee.update({project_id: project_id})
  @projects = Project.all()
  erb(:employee)
end

delete("/project/:id/edit") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @divisions = Division.all()
  @projects = Project.all()
  erb(:index)
end

post("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  employee = Employee.find(params.fetch("employee_id").to_i())
  project_id = @project.id()
  employee.update({project_id: project_id})
  @projects = Project.all()
  @employees = Employee.all()
  erb(:project)
end

patch("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  employee = Employee.find(params.fetch("employee_id").to_i())

  employee.update({project_id: nil})
  @projects = Project.all()
  @employees = Employee.all()
  erb(:project)
end
