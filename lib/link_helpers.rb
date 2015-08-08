module LinkHelpers

  def slugify_snakecase(snakecase_string)
    snakecase_string.gsub("_", "-")
  end
end
