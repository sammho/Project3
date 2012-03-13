module ApplicationHelper

  ## Given an array of meetup of topics, return a randomized subset up to the number specified
  def get_rand_meetup_topics(topics_id_array, num_topics)
    ## The easy way is to return the first number up to index
    i = 0
    topic_objects = [] 
    total = topics_id_array.count

    while i < num_topics || i >= total
      topic = MeetupTopic.find_by_meetup_id(topics_id_array[i])
      topic_objects << topic
      i += 1
    end

    return topic_objects
  end

end
