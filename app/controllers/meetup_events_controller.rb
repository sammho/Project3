class MeetupEventsController < ApplicationController
  # GET /meetup_events
  # GET /meetup_events.json
  require 'iconv'

  RMeetup::Client.api_key = "1f5d31256d715b1f31295f74324c3d21"
  
  def index
    @meetup_events = MeetupEvent.all

    #@results = RMeetup::Client.fetch(:members,{:member_id => "6442685"})
   # @results = RMeetup::Client.fetch(:events,{:member_id => "6442685", :text_format => "plain"})
    @results = RMeetup::Client.fetch(:events,{:member_id => current_user.meetup_member_id})

   # test_result = @results.first
   # puts "***************\n"
   # puts "Is object frozen? #{test_result.frozen?}"
   # puts test_result.frozen?
   # puts "#{test_result.inspect}"
   # puts "Name is #{test_result.name}"
   # test_result.name = "test"
   # puts "New name is #{test_result.name}"

   # @results.map do |result|
   #   ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
   #   clean_name = ic.iconv(result.name + ' ')[0..-2]
   #   result.name = clean_name
   #   if clean_name != result.name 
   #     puts "Name:    #{result.name} \ncleaned: #{clean_name}"
   #     puts "#{result.to_yaml}"
   #   end

   # end

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

    @event_details = RMeetup::Client.fetch(:events,{:id => params[:id]}).first

    @meetup_rsvps = RMeetup::Client.fetch(:rsvps,{:event_id => params[:id]})
    @rsvpd_members = []

    @meetup_rsvps.each do |meetup_member|

      # TODO: I should be able to change this to first_or_create!
      if MeetupMember.find_by_meetup_id(meetup_member.member_id)
        newfound_member =  MeetupMember.find_by_meetup_id(meetup_member.member_id)
        @rsvpd_members <<  newfound_member

      else
        newfound_member =  MeetupMember.create_new_from_meetup(meetup_member.member_id)
        @rsvpd_members << newfound_member
      end

      #puts "AR Errors? #{newfound_member.errors.inspect}\n"

      #if newfound_member.unparsed_json.nil?
      #  puts "ERROR1: #{newfound_member.inspect}\n"
      #else
      #  puts "SUCCESS_inspect #{newfound_member.inspect}\n"
      #  puts "SUCCESS: #{newfound_member.meetup_id}\n"
      #end
      current_user.calculate_affinity(newfound_member)

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
