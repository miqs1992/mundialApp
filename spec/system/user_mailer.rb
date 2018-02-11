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
end