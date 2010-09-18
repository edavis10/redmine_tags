module RedmineTags
  module Hooks
    class ViewIssuesFormDetailsBottomHook < Redmine::Hook::ViewListener
      render_on :view_issues_form_details_bottom, :partial => 'issues/tag_form'
    end
  end
end
