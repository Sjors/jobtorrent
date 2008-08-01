require 'test_helper'

class EmployersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:employers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_employer
    assert_difference('Employer.count') do
      post :create, :employer => { }
    end

    assert_redirected_to employer_path(assigns(:employer))
  end

  def test_should_show_employer
    get :show, :id => employers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => employers(:one).id
    assert_response :success
  end

  def test_should_update_employer
    put :update, :id => employers(:one).id, :employer => { }
    assert_redirected_to employer_path(assigns(:employer))
  end

  def test_should_destroy_employer
    assert_difference('Employer.count', -1) do
      delete :destroy, :id => employers(:one).id
    end

    assert_redirected_to employers_path
  end
end
