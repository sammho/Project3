class MeetupTopicsController < ApplicationController
  # GET /meetup_topics
  # GET /meetup_topics.json
  def index
    @meetup_topics = MeetupTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetup_topics }
    end
  end

  # GET /meetup_topics/1
  # GET /meetup_topics/1.json
  def show
    @meetup_topic = MeetupTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meetup_topic }
    end
  end

  # GET /meetup_topics/new
  # GET /meetup_topics/new.json
  def new
    @meetup_topic = MeetupTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meetup_topic }
    end
  end

  # GET /meetup_topics/1/edit
  def edit
    @meetup_topic = MeetupTopic.find(params[:id])
  end

  # POST /meetup_topics
  # POST /meetup_topics.json
  def create
    @meetup_topic = MeetupTopic.new(params[:meetup_topic])

    respond_to do |format|
      if @meetup_topic.save
        format.html { redirect_to @meetup_topic, notice: 'Meetup topic was successfully created.' }
        format.json { render json: @meetup_topic, status: :created, location: @meetup_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @meetup_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetup_topics/1
  # PUT /meetup_topics/1.json
  def update
    @meetup_topic = MeetupTopic.find(params[:id])

    respond_to do |format|
      if @meetup_topic.update_attributes(params[:meetup_topic])
        format.html { redirect_to @meetup_topic, notice: 'Meetup topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @meetup_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetup_topics/1
  # DELETE /meetup_topics/1.json
  def destroy
    @meetup_topic = MeetupTopic.find(params[:id])
    @meetup_topic.destroy

    respond_to do |format|
      format.html { redirect_to meetup_topics_url }
      format.json { head :ok }
    end
  end
end
