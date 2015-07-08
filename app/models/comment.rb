class Comment < ActiveRecord::Base
  #attr_accessible :commenter, :body
  belongs_to :article
  belongs_to :user
end
