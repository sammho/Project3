require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MeetupMembersController do

  # This should return the minimal set of attributes required to create a valid
  # MeetupMember. As you add validations to MeetupMember, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all meetup_members as @meetup_members" do
      meetup_member = MeetupMember.create! valid_attributes
      get :index
      assigns(:meetup_members).should eq([meetup_member])
    end
  end

  describe "GET show" do
    it "assigns the requested meetup_member as @meetup_member" do
      meetup_member = MeetupMember.create! valid_attributes
      get :show, :id => meetup_member.id.to_s
      assigns(:meetup_member).should eq(meetup_member)
    end
  end

  describe "GET new" do
    it "assigns a new meetup_member as @meetup_member" do
      get :new
      assigns(:meetup_member).should be_a_new(MeetupMember)
    end
  end

  describe "GET edit" do
    it "assigns the requested meetup_member as @meetup_member" do
      meetup_member = MeetupMember.create! valid_attributes
      get :edit, :id => meetup_member.id.to_s
      assigns(:meetup_member).should eq(meetup_member)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new MeetupMember" do
        expect {
          post :create, :meetup_member => valid_attributes
        }.to change(MeetupMember, :count).by(1)
      end

      it "assigns a newly created meetup_member as @meetup_member" do
        post :create, :meetup_member => valid_attributes
        assigns(:meetup_member).should be_a(MeetupMember)
        assigns(:meetup_member).should be_persisted
      end

      it "redirects to the created meetup_member" do
        post :create, :meetup_member => valid_attributes
        response.should redirect_to(MeetupMember.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved meetup_member as @meetup_member" do
        # Trigger the behavior that occurs when invalid params are submitted
        MeetupMember.any_instance.stub(:save).and_return(false)
        post :create, :meetup_member => {}
        assigns(:meetup_member).should be_a_new(MeetupMember)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MeetupMember.any_instance.stub(:save).and_return(false)
        post :create, :meetup_member => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested meetup_member" do
        meetup_member = MeetupMember.create! valid_attributes
        # Assuming there are no other meetup_members in the database, this
        # specifies that the MeetupMember created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        MeetupMember.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => meetup_member.id, :meetup_member => {'these' => 'params'}
      end

      it "assigns the requested meetup_member as @meetup_member" do
        meetup_member = MeetupMember.create! valid_attributes
        put :update, :id => meetup_member.id, :meetup_member => valid_attributes
        assigns(:meetup_member).should eq(meetup_member)
      end

      it "redirects to the meetup_member" do
        meetup_member = MeetupMember.create! valid_attributes
        put :update, :id => meetup_member.id, :meetup_member => valid_attributes
        response.should redirect_to(meetup_member)
      end
    end

    describe "with invalid params" do
      it "assigns the meetup_member as @meetup_member" do
        meetup_member = MeetupMember.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MeetupMember.any_instance.stub(:save).and_return(false)
        put :update, :id => meetup_member.id.to_s, :meetup_member => {}
        assigns(:meetup_member).should eq(meetup_member)
      end

      it "re-renders the 'edit' template" do
        meetup_member = MeetupMember.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MeetupMember.any_instance.stub(:save).and_return(false)
        put :update, :id => meetup_member.id.to_s, :meetup_member => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested meetup_member" do
      meetup_member = MeetupMember.create! valid_attributes
      expect {
        delete :destroy, :id => meetup_member.id.to_s
      }.to change(MeetupMember, :count).by(-1)
    end

    it "redirects to the meetup_members list" do
      meetup_member = MeetupMember.create! valid_attributes
      delete :destroy, :id => meetup_member.id.to_s
      response.should redirect_to(meetup_members_url)
    end
  end

end