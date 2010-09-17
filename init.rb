require 'redmine'

Redmine::Plugin.register :redmine_tags do
  name 'Redmine Tags'
  author 'Eric Davis'
  description 'Adds tagging to Redmine'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-tags'
  author_url 'http://www.littlestreamsoftware.com'

  version '0.1.0'

  requires_redmine :version_or_higher => '1.0.0'
end
