class MeetupEventsController < ApplicationController
  # GET /meetup_events
  # GET /meetup_events.json
  require 'iconv'

  RMeetup::Client.api_key = "1f5d31256d715b1f31295f74324c3d21"
  
  def index
    @meetup_events = MeetupEvent.all

    #@results = RMeetup::Client.fetch(:members,{:member_id => "6442685"})
    @results = RMeetup::Client.fetch(:events,{:member_id => "6442685"})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetup_events }
    end
  end

  # GET /meetup_events/1
  # GET /meetup_events/1.json
  def show
    # Removing this as the meetup event won't be stored in the DB for now
    # TODO: figure out how to create a duplicate entry
    # @meetup_event = MeetupEvent.find(params[:id])

    # Unfortunately the old events doesn't support this lookup
    #@event_details = RMeetup::Client.fetch(:events,{:event_id => params[:id]})

    @meetup_rsvps = RMeetup::Client.fetch(:rsvps,{:event_id => params[:id]})
    @rsvpd_members = []

    @meetup_rsvps.each do |meetup_member|

      # TODO: I should be able to change this to first_or_create!
      if MeetupMember.find_by_meetup_id(meetup_member.member_id)
        found_member =  MeetupMember.find_by_meetup_id(meetup_member.member_id)
        @rsvpd_members <<  found_member

      else
        # What if I create an empty member and then update it or call update function?
        #@rsvpd_members << create_member_from_meetup_api(meetup_member.member_id)
        new_member_id = meetup_member.member_id
        new_member = MeetupMember.create!(:meetup_id => meetup_member.member_id)
        @rsvpd_members << new_member.update_member_from_meetup_api(new_member_id)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meetup_event }
    end
  end

  # GET /meetup_events/new
  # GET /meetup_events/new.json
  def new
    @meetup_event = MeetupEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meetup_event }
    end
  end

  # GET /meetup_events/1/edit
  def edit
    @meetup_event = MeetupEvent.find(params[:id])
  end

  # POST /meetup_events
  # POST /meetup_events.json
  def create
    @meetup_event = MeetupEvent.new(params[:meetup_event])

    respond_to do |format|
      if @meetup_event.save
        format.html { redirect_to @meetup_event, notice: 'Meetup event was successfully created.' }
        format.json { render json: @meetup_event, status: :created, location: @meetup_event }
      else
        format.html { render action: "new" }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetup_events/1
  # PUT /meetup_events/1.json
  def update
    @meetup_event = MeetupEvent.find(params[:id])

    respond_to do |format|
      if @meetup_event.update_attributes(params[:meetup_event])
        format.html { redirect_to @meetup_event, notice: 'Meetup event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetup_events/1
  # DELETE /meetup_events/1.json
  def destroy
    @meetup_event = MeetupEvent.find(params[:id])
    @meetup_event.destroy

    respond_to do |format|
      format.html { redirect_to meetup_events_url }
      format.json { head :ok }
    end
  end
end
