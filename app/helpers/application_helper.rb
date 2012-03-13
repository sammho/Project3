module ApplicationHelper

  ## Given an array of meetup of topics, return a randomized subset up to the number specified
  def get_rand_meetup_topics(topics_id_array, num_topics)
    ## The easy way is to return the first number up to index
    i = 0
    topic_objects = [] 
    total = topics_id_array.count

    while i < num_topics 
      topic = MeetupTopic.find_by_meetup_id(topics_id_array[i])
      topic_objects << topic
      i += 1
      break if i >= total
    end

    return topic_objects
  end

  ## Given an array of meetup topics, output the topic names linked to their URLs separated by a space
  def print_meetup_topics(topics)
    topic_string = ""

    topics.each do |topic|
      topic_string << "#{link_to(topic.name, topic.urlkey)} "
    end
    
    return raw(topic_string)

  end

end
