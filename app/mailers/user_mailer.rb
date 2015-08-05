class UserMailer < ApplicationMailer
  
 default :from => "fathimaayar@gmail.com"

 def registration_confirmation(user)
   @user = user
   @url = confirm_email_user_url(user.confirm_token) 
   mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
 end
 
 def password_reset_instructions(user)
   @user = user
   @url = edit_password_reset_url(user.perishable_token)
   mail(:to => "<#{user.email}>", :subject => "Password Reset")
 end  
  
end
