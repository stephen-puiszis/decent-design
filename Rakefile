require 'date'

namespace :middleman do
  desc "creates a new post skeleton with required fontmatter"
  task :new, :filetype do
    File.open("./source/posts/#{Date.today.to_s}-new-post.html.haml", 'w+') do |f|
      template = <<-fontmatter.gsub(/^[\s]*/, '')
                  ---
                  title: Example Title
                  date: #{Date.today.to_s}
                  company_key: something
                  elements: add me to data as well
                  description: fix this up
                  preview_image_url: http://placehold.it/250x250/07ebc5/596f70
                  ---
                  fontmatter
      f.write(template)
      puts "successfully created file!"
    end
  end
end
