module ApplicationHelper

  ## Given an array of meetup of topics, return a randomized subset up to the number specified
  def get_rand_meetup_topics(topics_id_array, num_topics)
    i = 0
    topic_objects = [] 
    total = topics_id_array.count

    rand_topics = topics_id_array.sort_by {rand}

    while i < num_topics 
      topic = MeetupTopic.find_by_meetup_id(rand_topics[i])
      topic_objects << topic
      i += 1
      break if i >= total
    end

    ## TODO: Add a more list if there are more, allow users to see all topics

    return topic_objects
  end

  ## Given an array of meetup topics, output the topic names linked to their URLs separated by a space
  def print_meetup_topics(topics)
    topic_string = ""

    topics.each do |topic|
      #topic_string << "#{link_to(topic.name, topic.urlkey)} "
      topic_string << "#{topic.name}, "
    end
    
    return raw(topic_string.chop.chop)

  end

  def get_rand_followers(followers_id_array, num_followers)
    i = 0
    follower_objects = [] 
    total = followers_id_array.count

    rand_followers = followers_id_array.sort_by {rand}

    while i < num_followers && i < 20 ## This sets the max amount at 20 
      follower = TwitterMember.find_or_create_from_twitter_id(rand_followers[i])

      follower_objects << follower
      i += 1
      break if i >= total
    end

    ## TODO: Add a more list if there are more, allow users to see all followers

    return follower_objects
  end

end
