class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  def meetup_member_id
   return MeetupMember.find_by_user_id(self.id).meetup_id
  end

  def topics_in_common(found_member)
    @my_topics = MeetupMember.find(self.id).unparsed_json

    @common_topics = []

    found_member.unparsed_json.each do |topic|
      if @my_topics.include?(topic)
        @common_topics << topic
      else
      end

    end
    
    puts "User #{self.id} topics in common: #{@common_topics} !"

    return @common_topics
  end

  def calculate_affinity(target_member)
    self.topics_in_common(target_member) # Is this necessary? 
    self.topics_in_common(target_member).count  

    MeetupMember.find_by_user_id(self.id).unparsed_json.count 
    target_member.unparsed_json.count 
    !target_member.linkedin_url.nil? 
    !target_member.twitter.nil? 

  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#

