require 'test_helper'

class GoogleCodeIssuesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:google_code_issues)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_google_code_issue
    assert_difference('GoogleCodeIssue.count') do
      post :create, :google_code_issue => { }
    end

    assert_redirected_to google_code_issue_path(assigns(:google_code_issue))
  end

  def test_should_show_google_code_issue
    get :show, :id => google_code_issues(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => google_code_issues(:one).id
    assert_response :success
  end

  def test_should_update_google_code_issue
    put :update, :id => google_code_issues(:one).id, :google_code_issue => { }
    assert_redirected_to google_code_issue_path(assigns(:google_code_issue))
  end

  def test_should_destroy_google_code_issue
    assert_difference('GoogleCodeIssue.count', -1) do
      delete :destroy, :id => google_code_issues(:one).id
    end

    assert_redirected_to google_code_issues_path
  end
end
