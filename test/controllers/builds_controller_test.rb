require 'test_helper'

class BuildsControllerTest < ActionController::TestCase
  setup do
    @build = builds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:builds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build" do
    assert_difference('Build.count') do
      post :create, build: { accessToken: @build.accessToken, buildIdenifier: @build.buildIdenifier, createDate: @build.createDate, displayname: @build.displayname, domain: @build.domain, icon: @build.icon, number: @build.number, platform: @build.platform, provision: @build.provision, releaseNotes: @build.releaseNotes, version: @build.version }
    end

    assert_redirected_to build_path(assigns(:build))
  end

  test "should show build" do
    get :show, id: @build
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build
    assert_response :success
  end

  test "should update build" do
    patch :update, id: @build, build: { accessToken: @build.accessToken, buildIdenifier: @build.buildIdenifier, createDate: @build.createDate, displayname: @build.displayname, domain: @build.domain, icon: @build.icon, number: @build.number, platform: @build.platform, provision: @build.provision, releaseNotes: @build.releaseNotes, version: @build.version }
    assert_redirected_to build_path(assigns(:build))
  end

  test "should destroy build" do
    assert_difference('Build.count', -1) do
      delete :destroy, id: @build
    end

    assert_redirected_to builds_path
  end
end
