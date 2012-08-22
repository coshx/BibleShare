require 'spec_helper'

describe PassagesController do

  def mock_passage(stubs={})
    (@mock_passage ||= mock_model(Passage).as_null_object).tap do |passage|
      passage.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all passages as @passages" do
      Passage.stub(:all) { [mock_passage] }
      get :index
      assigns(:passages).should eq([mock_passage])
    end
  end

  describe "GET show" do
    it "assigns the requested passage as @passage" do
      Passage.stub(:find).with("37") { mock_passage }
      get :show, :id => "37"
      assigns(:passage).should be(mock_passage)
    end
  end

  describe "GET new" do
    it "assigns a new passage as @passage" do
      Passage.stub(:new) { mock_passage }
      get :new
      assigns(:passage).should be(mock_passage)
    end
  end

  describe "GET edit" do
    it "assigns the requested passage as @passage" do
      Passage.stub(:find).with("37") { mock_passage }
      get :edit, :id => "37"
      assigns(:passage).should be(mock_passage)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created passage as @passage" do
        Passage.stub(:new).with({'these' => 'params'}) { mock_passage(:save => true) }
        post :create, :passage => {'these' => 'params'}
        assigns(:passage).should be(mock_passage)
      end

      it "redirects to the created passage" do
        Passage.stub(:new) { mock_passage(:save => true) }
        post :create, :passage => {}
        response.should redirect_to(passage_url(mock_passage))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved passage as @passage" do
        Passage.stub(:new).with({'these' => 'params'}) { mock_passage(:save => false) }
        post :create, :passage => {'these' => 'params'}
        assigns(:passage).should be(mock_passage)
      end

      it "re-renders the 'new' template" do
        Passage.stub(:new) { mock_passage(:save => false) }
        post :create, :passage => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested passage" do
        Passage.should_receive(:find).with("37") { mock_passage }
        mock_passage.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :passage => {'these' => 'params'}
      end

      it "assigns the requested passage as @passage" do
        Passage.stub(:find) { mock_passage(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:passage).should be(mock_passage)
      end

      it "redirects to the passage" do
        Passage.stub(:find) { mock_passage(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(passage_url(mock_passage))
      end
    end

    describe "with invalid params" do
      it "assigns the passage as @passage" do
        Passage.stub(:find) { mock_passage(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:passage).should be(mock_passage)
      end

      it "re-renders the 'edit' template" do
        Passage.stub(:find) { mock_passage(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested passage" do
      Passage.should_receive(:find).with("37") { mock_passage }
      mock_passage.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the passages list" do
      Passage.stub(:find) { mock_passage }
      delete :destroy, :id => "1"
      response.should redirect_to(passages_url)
    end
  end

end
