require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    @issue = issues(:one)
  end

  test "should get index" do
    get project_issues_url(@project)
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get new" do
    get new_project_issue_url(@project)
    assert_response :success
  end

  test "should create issue" do
    assert_difference('Issue.count') do
      post project_issues_url(@project), params: {
        issue: {
          title: 'New Issue',
          status: 'New',
          priority: 3,
          project_id: @project.id
        }
      }
    end

    assert_redirected_to project_issue_url(@project, Issue.last)
    assert_equal 'Issue was successfully created.', flash[:notice]
  end

  test "should not create invalid issue" do
    assert_no_difference('Issue.count') do
      post project_issues_url(@project), params: {
        issue: {
          title: '',
          status: 'New',
          priority: 3
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should show issue" do
    get project_issue_url(@project, @issue)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_issue_url(@project, @issue)
    assert_response :success
  end

  test "should update issue" do
    patch project_issue_url(@project, @issue), params: {
      issue: {
        title: 'Updated Title'
      }
    }

    assert_redirected_to project_issue_url(@project, @issue)
    assert_equal 'Issue was successfully updated.', flash[:notice]
    @issue.reload
    assert_equal 'Updated Title', @issue.title
  end

  test "should destroy issue" do
    assert_difference('Issue.count', -1) do
      delete project_issue_url(@project, @issue)
    end

    assert_redirected_to project_issues_url(@project)
    assert_equal 'Issue was successfully destroyed.', flash[:notice]
  end

  test "should get reports" do
    get reports_project_issues_url(@project)
    assert_response :success
    assert_not_nil assigns(:status_counts)
    assert_not_nil assigns(:priority_counts)
  end

test "should export xlsx" do
  get export_project_issues_url(@project, format: :xlsx)
  assert_response :success
  assert_includes response.content_type, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
end
end
