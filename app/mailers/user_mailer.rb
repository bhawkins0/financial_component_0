class UserMailer < ApplicationMailer
    default from: 'bhawkins2012@gmail.com'
    def test_add_email
        @user = 'Brennan'
        mail(to: 'bhawkins2012@gmail.com', subject: 'Welcome to My Awesome Site')
    end
end
