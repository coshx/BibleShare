require "spec_helper"

describe PassagesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/passages" }.should route_to(:controller => "passages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/passages/new" }.should route_to(:controller => "passages", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/passages/1" }.should route_to(:controller => "passages", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/passages/1/edit" }.should route_to(:controller => "passages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/passages" }.should route_to(:controller => "passages", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/passages/1" }.should route_to(:controller => "passages", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/passages/1" }.should route_to(:controller => "passages", :action => "destroy", :id => "1")
    end

  end
end
