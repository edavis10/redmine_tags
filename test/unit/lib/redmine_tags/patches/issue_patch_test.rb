require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineTags::Patches::IssueTest < ActionController::TestCase
  subject { Issue.new }
  
  context "Issue" do
    context "tagging" do
      should_have_named_scope 'tagged_with("tag")'

      should "add new tags with #tag_list" do
        @project = Project.generate!
        @issue = Issue.generate_for_project!(@project)
        assert @issue.tag_list.empty?

        @issue.tag_list = ["ruby", "mysql", "python", "ruby"]
        assert @issue.save
        @issue.reload

        assert @issue.tag_list.include?("ruby"), "Missing tag"
        assert @issue.tag_list.include?("mysql"), "Missing tag"
        assert @issue.tag_list.include?("python"), "Missing tag"
        assert_equal 3, @issue.tag_list.size, "Duplicated tags"
      end
    end
  end
end

