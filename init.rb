config.gem "acts-as-taggable-on", :version => '2.0.4'

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

require 'dispatcher'
Dispatcher.to_prepare :redmine_tags do
  require_dependency 'issue'
  unless Issue.included_modules.include?(RedmineTags::Patches::IssuePatch)
    Issue.send(:include, RedmineTags::Patches::IssuePatch)
  end
end

require 'redmine_tags/hooks/view_issues_form_details_bottom_hook'
require 'redmine_tags/hooks/view_issues_show_description_bottom_hook'
require 'redmine_tags/hooks/issue_before_save_hook'
