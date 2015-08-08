module DataHelpers

  # register data types
  # RESOURCES = { company: :companies, industry: :industries, element: :elements, device: :devices }.freeze

  # find - public
  #
  # search for specific key in data hash
  def find(resource, key)
    data.send(resource)[key] || nil
  end

  # public - search the blog for a specific resource key, singluar
  def find_articles(resource, key)
    blog.articles.find_all { |article| article.data.send(resource) == key }
  end

  # public - check to see if resource has a logo already, otherwise hit clearbit logo api
  def logo_url(resource, key, size)
    hash = find(resource, key)
    if hash.has_key?(:logo_url)
      hash[:logo_url]
    else
      path = hash[:url].gsub("http://", "")
      "https://logo.clearbit.com/#{path}?size=#{size}"
    end
  end

  def companies
    data.companies
  end

  def industries
    data.industries
  end
end
