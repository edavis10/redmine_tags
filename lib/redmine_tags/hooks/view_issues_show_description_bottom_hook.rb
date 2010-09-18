module RedmineTags
  module Hooks
    class ViewIssuesShowDescriptionBottomHook < Redmine::Hook::ViewListener
      render_on :view_issues_show_description_bottom, :partial => 'issues/tags'
    end
  end
end
