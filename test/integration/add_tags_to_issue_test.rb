require File.dirname(__FILE__) + '/../test_helper'

class AddTagsToIssueTest < ActionController::IntegrationTest
  include Redmine::Hook::Helper

  def setup
    IssueStatus.generate!(:is_default => true)
    @user = User.generate!(:login => 'test', :password => 'test', :password_confirmation => 'test')
    @project = Project.generate!.reload
    @issue = Issue.generate_for_project!(@project)
    User.add_to_project(@user, @project, Role.generate!(:permissions => [:view_issues, :add_issues, :edit_issues]))
    login_as('test', 'test')
  end

  should "show current tags" do
    @issue.tag_list = ["ruby", "redmine"]
    assert @issue.save
    
    visit_issue_page(@issue)

    assert_select "#tag_list" do
      assert_select "tr td", :text => /ruby/
      assert_select "tr td", :text => /redmine/
    end
  end
  
  should "show a form field to input new tags" do
    visit_issue_page(@issue)

    click_link "Update"
    assert_response :success

    assert_select "input#issue_tag_list"

  end

  should "set tags based on a comma separated string to an existing issue" do
    visit_issue_page(@issue)

    click_link "Update"
    assert_response :success

    fill_in "Tags", :with => 'Ruby, Rails Redmine'
    click_button "Submit"

    assert_equal "http://www.example.com/issues/#{@issue.id}", current_url
    assert_response :success

    assert_equal ["Ruby", "Rails Redmine"], @issue.reload.tag_list

    last_journal = @issue.journals.last
    assert last_journal
    assert_equal 1, last_journal.details.size
    last_journal_details = last_journal.details.first
    assert_equal 'tag_list', last_journal_details.prop_key
    assert_equal 'Ruby, Rails Redmine', last_journal_details.value
    assert_equal '', last_journal_details.old_value

  end

  should "set tags based on a comma separated string to a new issue" do
    visit_project(@project)

    click_link "New issue"
    assert_response :success

    fill_in "Subject", :with => 'Tag test'
    fill_in "Tags", :with => 'Ruby, Rails Redmine'
    assert_difference("Issue.count") do
      click_button "Create"
    end

    assert_response :success
    assert_equal ["Ruby", "Rails Redmine"], Issue.last.tag_list

    assert_equal 0, @issue.journals.count, "Journal was created an a new issue when it shouldn't have been"

  end
end
