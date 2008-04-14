require File.dirname(__FILE__) + '/../test_helper'

class ThoughtWorkersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:thought_workers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_thought_worker
    assert_difference('ThoughtWorker.count') do
      post :create, :thought_worker => { }
    end

    assert_redirected_to thought_worker_path(assigns(:thought_worker))
  end

  def test_should_show_thought_worker
    get :show, :id => thought_workers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => thought_workers(:one).id
    assert_response :success
  end

  def test_should_update_thought_worker
    put :update, :id => thought_workers(:one).id, :thought_worker => { }
    assert_redirected_to thought_worker_path(assigns(:thought_worker))
  end

  def test_should_destroy_thought_worker
    assert_difference('ThoughtWorker.count', -1) do
      delete :destroy, :id => thought_workers(:one).id
    end

    assert_redirected_to thought_workers_path
  end
end
