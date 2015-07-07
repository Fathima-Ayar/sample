class Article < ActiveRecord::Base
 attr_accessible :title, :text
 belongs_to :user
 has_many :comments, dependent: :destroy
 acts_as_votable
end
