class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  def topics_in_common(found_member)
    @my_topics = MeetupMember.find(self.id).unparsed_json

      ## This section needs to be moved out of this if loop to run for both
      ## TODO: Should be defined as a separate funciton
      @common_topics = []

      found_member.unparsed_json.each do |topic|
        if @my_topics.include?(topic)
          @common_topics << topic
        else
        end

      end
      
      puts "User topics in common: #{@common_topics} !"

      return @common_topics

      # TODO: this is really broken as it relies on all members being found
      # If any members require meetup api lookup it will throw off the array alignment
      #@topics_in_common_by_member << num_topics_in_common
      #####################################################################

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

