require 'csv'

import = ->(klass, file_path) do
  CSV.foreach(Rails.root.join(file_path), headers: true).each_slice(1000) do |rows|
    save_data = rows.map { |row| row.to_h.merge({ created_at: Time.current, updated_at: Time.current }) }
    klass.insert_all! save_data
  end
end

TestPost.create!(
  [
    { title: 'Ruby' },
    { title: 'Rails' },
    { title: 'Next.js' },
    { title: 'React' }
  ]
) unless TestPost.exists?

# Tech
unless Tech.exists?
  ActiveRecord::Base.transaction do
    puts 'start Tech import'
    import.call Tech, 'db/seeds/tech.csv'
    puts "end Tech import count: #{Tech.count}"

    puts 'start Tech parent settings'
    parent = Tech.find_by(name: 'JavaScript')
    Tech.where(name: ['Angular', 'React', 'TypeScript', 'Vue.js']).update!(parent:)
    parent = Tech.find_by(name: 'PHP')
    Tech.where(name: ['CakePHP', 'Laravel']).update!(parent:)
    parent = Tech.find_by(name: 'Python')
    Tech.where(name: 'Django').update!(parent:)
    parent = Tech.find_by(name: 'React')
    Tech.where(name: 'Next.js').update!(parent:)
    parent = Tech.find_by(name: 'Vue.js')
    Tech.where(name: 'Nuxt.js').update!(parent:)
    parent = Tech.find_by(name: 'Swift')
    Tech.where(name: ['Perfect', 'Slimane']).update!(parent:)
    parent = Tech.find_by(name: 'Elixir')
    Tech.where(name: 'Phoenix').update!(parent:)
    parent = Tech.find_by(name: 'Scala')
    Tech.where(name: 'Play Framework').update!(parent:)
    parent = Tech.find_by(name: 'Ruby')
    Tech.where(name: 'Ruby on Rails').update!(parent:)
    parent = Tech.find_by(name: 'CSS')
    Tech.where(name: 'Sass').update!(parent:)
    parent = Tech.find_by(name: 'Java')
    Tech.where(name: ['SAStruts', 'Spring Boot']).update!(parent:)
    puts 'end Tech parent settings'
  end
end
