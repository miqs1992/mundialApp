require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe 'User mailer', :type => :system do
    it 'can recover password' do
        ActiveJob::Base.queue_adapter = :test
        user = FactoryBot.create(:user)
        visit "/login"
        click_on "Zapomniałeś hasła?"
        fill_in 'user[email]', :with => user.email
        expect { click_on "Wyślij" }.to have_enqueued_job.on_queue('mailers')
    end

    it 'sends email after creating user' do
        admin = FactoryBot.create(:user, :admin)
        login_as(admin)
        visit new_user_path
        fill_in 'user[login]', :with => 'userlogin'
        fill_in 'user[first_name]', :with => 'Name'
        fill_in 'user[last_name]', :with => 'Surname'
        fill_in 'user[email]', :with => 'example@example.com'
        expect { click_on "Utwórz konto" }.to have_enqueued_job.on_queue('mailers')
    end
end