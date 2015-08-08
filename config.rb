require "lib/data_helpers"
require "lib/link_helpers"
helpers DataHelpers, LinkHelpers
Secrets = YAML::load(File.open('secrets.yml'))

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# Resources
# /elements/
# /elements/#{element-name}
# /devices/
# /#{devices}/#{device-name}
# /companies/
# /companies/#{company-name}
# /industries/#{industry}/
# /industries/#{industry}/#{sub-sector-name}
# /tags/
# /tags/#{tag-name}
# page "/companies.html", layout: "companies"
# page "/devices.html", layout: "devices"
# page "/elements.html", layout: "elements"
# page "/industries.html"
# proxy "/industries.html", "industries.html", layout: false

data[:industries].each do |name|
  proxy "/industries/#{slugify_snakecase(name)}.html", "/industries/show.html",
    locals: { industry: name },
    ignore: true
end

data[:companies].each do |key, hash|
  proxy "/companies/#{slugify_snakecase(key)}.html", "/companies/show.html",
    locals: { company: hash.merge(key: key) },
    ignore: true
end

activate :directory_indexes
activate :blog do |blog|
  blog.permalink  = "{title}"
  blog.sources    = "posts/{year}-{month}-{day}-{title}" # Matcher for blog source files
  blog.layout     = "post"

  blog.tag_template = "tag.html"
  blog.taglink      = "tags/{tag}.html"
  # blog.calendar_template = "calendar.html"

  blog.default_extension = ".markdown"
  blog.summary_separator = /READMORE/

  # Pagination
  blog.paginate   = true
  blog.per_page   = 10
  blog.page_link  = "page/{num}"
end

set :site_author, Secrets["site"]["author"]
set :site_title, Secrets["site"]["title"]
set :site_description, Secrets["site"]["description"]
set :site_keywords, Secrets["site"]["keywords"]

set :fonts_dir, 'stylesheets/fonts'
set :markdown_engine, :redcarpet
set :haml, { ugly: true }
set :markdown, {
  fenced_code_blocks: true,
  smartypants:        true,
  tables:             true,
  strikethrough:      true,
  footnotes:          true,
  superscript:        true,
  autolink:           true,
}

configure :development do
  require 'pry'
  activate :livereload

  # Services we don't want sending data in development
  set :google_verification_tag, "abc123"
  set :analytics_key, "abc123"
  set :disqus_key,    "abc123"
  set :swiftype_key,  "abc123"
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html

  # Production settings for external services
  set :google_site_verification_key, Secrets["google"]["site_verification_key"]
  set :google_analytics_key, Secrets["google"]["analytics_key"]
  set :disqus_key,    Secrets["disqus_key"]
  set :swiftype_key,  Secrets["swiftype_key"]
end
