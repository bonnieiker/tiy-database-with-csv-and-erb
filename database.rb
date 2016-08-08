require "csv"
require "erb"

class People
  attr_accessor :name, :phone, :address, :position, :salary, :github

  def initialize(name)
    @name = name
    @phone = phone
    @address = address
    @position = position
    @salary = salary
    @github = github
  end
end

class Menu
  def initialize
    @people = []

    CSV.foreach("employees.csv", { headers: true, header_converters: :symbol }) do |employee|
      person = People.new(employee)

      person.name     = employee[:name]
      person.phone    = employee[:phone]
      person.address  = employee[:address]
      person.position = employee[:position]
      person.salary   = employee[:salary]
      person.github   = employee[:github]

      @people << person
    end
  end

  def prompt
    loop do
      puts "A for Add a person"
      puts "S for Search for a person"
      puts "D for Delete a person"
      puts "R for Employee Report"
      puts "E for Exit"

      choice = gets.chomp
      break if choice == "E"

      case choice
      when "A"
        add_person
      when "S"
        search_person
      when "D"
        delete_person
      when "R"
        report
      else
        puts "These are your only options"
      end
    end
  end

  def write
    CSV.open("employees.csv", "w") do |csv|
      csv << %w{name phone address position salary github}
      @people.each do |person|
        csv << [person.name, person.phone, person.address, person.position,person.salary, person.github]
      end
    end
  end

  def add_person
    puts "Enter employee first and last name"
    person.name = gets.chomp

    person = People.new(name)

    puts "Enter employee phone number"
    person.phone = gets.chomp

    puts "Enter employee address"
    person.address = gets.chomp

    puts "Employee's position"
    person.position = gets.chomp

    puts "Employee's salary"
    person.salary = gets.chomp.to_i

    puts "Employee's github account"
    person.github = gets.chomp

    @people << person

    write
    puts "#{@people [-1].name} has been added to your database."
  end

  def found(person)
    puts "Employee is listed:
          #{person.name}
          #{person.phone}
          #{person.address}
          #{person.position}
          #{person.salary}.to_i
          #{person.github}"
  end

  def search_person
    puts "Whom is it for which you look?"
    search_person = gets.chomp
    matching_person = @people.find { |person| person.name == search_person }
    if !matching_person.nil?
      found(matching_person)
  else puts "#{search_person}not found"
    def search
        puts "Name? "
        search_name = gets.chomp
        found_person = @people.find { |person| person.name == search_name }
          if found_person
       +    File.open("search.html", "w") do |file|
       +        file.puts HTML_TOP
       +        prints_person(file, found_person)
       +        file.puts HTML_BOTTOM
       +      end
       +    else
       +      puts "Nope"
       +    end
       +  end
       +


    end
  end

  def delete_person
    puts "Delete which Employee? "
    delete_employee = gets.chomp
    matching_person = @people.find { |person| person.name == delete_person }
    for person in @people
      if !matching_person.nil?
        @people.delete(matching_person)
        write
        puts "#{person.name} has been deleted."
        break
      else
        puts "Person not found"
      end
    end
  end

  def employee_count(search_position)
    number_of_people_with_that_position = @people.count { |person| person.position = search_position }
  end

  def minimum_salary(search_position)
    matching_people = @people.select { |person| person.position = search_position }

    salaries = matching_people.map { |person| person.salary }

    smallest_salary = salaries.min

    return smallest_salary
  end

  def maximum_salary(search_position)
    matching_people = @people.select { |person| person.position = search_position }

    salaries = matching_people.map { |person| person.salary }

    largest_salary = salaries.max

    return largest_salary
  end

  def average_salary(search_position)
    matching_people = @people.select { |person| person.position = search_position }
    salaries = matching_people.map {|person| person.salary }
    total = 0
    salaries.each do |salary|
      toatal = total + salary
  end

  def employee_names(search_position)
    matching_people = @people.select { |person| person.position = search_position }

    names = matching_people.map { |person| person.name }

    combined_names = nams.join(",")

    return combined_names
  end

  def report
    puts "An employee report is being created for you now"
    html_template_file = File.read("template.html.erb")

    erb_template = ERB.new(html_template_from_disk)

    positions = @people.map { |person| person. position }

    positions.uniq!

    output = erb_template.result(binding)

    File.open("report.html", "w") do |file|
      file.puts output
    end
  end
end

menu = Menu.new()
menu.prompt
