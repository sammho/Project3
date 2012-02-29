class MeetupMembersController < ApplicationController
  # GET /meetup_members
  # GET /meetup_members.json
  def index
    @meetup_members = MeetupMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetup_members }
    end
  end

  # GET /meetup_members/1
  # GET /meetup_members/1.json
  def show
    @meetup_member = MeetupMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meetup_member }
    end
  end

  # GET /meetup_members/new
  # GET /meetup_members/new.json
  def new
    @meetup_member = MeetupMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meetup_member }
    end
  end

  # GET /meetup_members/1/edit
  def edit
    @meetup_member = MeetupMember.find(params[:id])
  end

  # POST /meetup_members
  # POST /meetup_members.json
  def create
    @meetup_member = MeetupMember.new(params[:meetup_member])

    respond_to do |format|
      if @meetup_member.save
        format.html { redirect_to @meetup_member, notice: 'Meetup member was successfully created.' }
        format.json { render json: @meetup_member, status: :created, location: @meetup_member }
      else
        format.html { render action: "new" }
        format.json { render json: @meetup_member.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /meetup_members/1
  # PUT /meetup_members/1.json
  def update
    @meetup_member = MeetupMember.find(params[:id])

    respond_to do |format|
      if @meetup_member.update_attributes(params[:meetup_member])
        format.html { redirect_to @meetup_member, notice: 'Meetup member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @meetup_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetup_members/1
  # DELETE /meetup_members/1.json
  def destroy
    @meetup_member = MeetupMember.find(params[:id])
    @meetup_member.destroy

    respond_to do |format|
      format.html { redirect_to meetup_members_url }
      format.json { head :ok }
    end
  end
end
