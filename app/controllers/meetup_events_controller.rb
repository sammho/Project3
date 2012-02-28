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
    @my_topics = MeetupMember.find_by_meetup_id(6442685).unparsed_json

    @topics_in_common_by_member = []

    @meetup_rsvps.each do |meetup_member|

      if MeetupMember.find_by_meetup_id(meetup_member.member_id)
        puts "success for #{meetup_member.member_id}"
        found_member =  MeetupMember.find_by_meetup_id(meetup_member.member_id)
        @rsvpd_members <<  found_member

        puts "Topics are #{found_member.unparsed_json}"
        #puts "Class is #{found_member.unparsed_json.class}"
        puts "Class is #{@my_topics.class}"
        puts "MyTopics is #{@my_topics}"


        #####################################################################
        ## This section needs to be moved out of this if loop to run for both
        ## TODO: Should be defined as a separate funciton
        num_topics_in_common = 0

        found_member.unparsed_json.each do |topic|
          if @my_topics.include?(topic)
            puts "Topic #{topic} matched!"
            num_topics_in_common += 1
          else
          end

        end

        # TODO: this is really broken as it relies on all members being found
        # If any members require meetup api lookup it will throw off the array alignment
        @topics_in_common_by_member << num_topics_in_common
        #####################################################################
        
      else
        # TODO: there is an issue here with utf-8 characters, so non-standard characters
        # cause an error
        member = RMeetup::Client.fetch(:members, {:member_id => meetup_member.member_id})
        puts "working on #{meetup_member.member_id} #{member.first.other_services} class is: #{member.first.other_services.class}"

        if member.first.other_services["linkedin"] && 
            member.first.other_services["linkedin"]["identifier"] =~ /.*linkedin.com.*/

            # for now, let's not extract the field, let's just use the link directly

          linked_in_url = member.first.other_services["linkedin"]["identifier"]
          #linkedin_re = /linkedin.com\/in\/(\w+)/
          #linked_in_url = linkedin_re.match(member.first.other_services["linkedin"]["identifier"])

          ## Technically this is just the name and not the URL
          #linked_in_url = $1

          puts "Found match for #{meetup_member.name}\n"

        else
          linked_in_url = nil 
          puts "Found  NO match for #{meetup_member.name}\n"
        end


        if member.first.other_services["twitter"]

            twitter = member.first.other_services["twitter"]["identifier"]

          puts "Found twitter match for #{meetup_member.name}\n"

        else
          twitter = nil
          puts "Found  NO twitter match for #{meetup_member.name}\n"
        end

        # Need to clean up bad utf-8 characters that are causing errors
        ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
        clean_name = ic.iconv(meetup_member.name + ' ')[0..-2]

        # Need to clean up topics because of utf-8, let's just pull out the topic ids and store
        @topics = []
        member.first.topics.each do |topic|
          topic_id = topic["id"].to_i
          @topics << topic["id"]

          if MeetupTopic.find_by_meetup_id(topic["id"])
            puts "Found #{topic["id"]}"

          else
            MeetupTopic.create!(:meetup_id => topic["id"],
                                :urlkey => topic["urlkey"],
                                :name => topic["name"])
          end

        end

        @rsvpd_members << MeetupMember.create!(:name => clean_name, 
                                                :meetup_id => meetup_member.member_id, 
                                                #:unparsed_json => member.first.topics,
                                                :unparsed_json => @topics, 
                                                :image_url => meetup_member.photo_url,
                                                :linkedin_url => linked_in_url,
                                                :twitter =>   twitter )
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
