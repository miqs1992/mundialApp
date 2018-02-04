require 'rails_helper'

RSpec.describe 'Login to application', :type => :system do
  it 'redirects to log in page' do
    visit '/'
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  it 'logs in by login' do
    user = FactoryBot.create(:user)
    visit '/'
    fill_in 'user[devise_login]', :with => user.login
    fill_in 'user[password]', :with => user.password
    click_on I18n.t('devise.sessions.log_in')
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  it 'logs in by email' do
    user = FactoryBot.create(:user)
    visit '/'
    fill_in 'user[devise_login]', :with => user.email
    fill_in 'user[password]', :with => user.password
    click_on I18n.t('devise.sessions.log_in')
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  it 'logs in with invalid data' do
    user = FactoryBot.create(:user)
    visit '/'
    fill_in 'user[devise_login]', :with => 'wrong_login'
    fill_in 'user[password]', :with => 'wrong_password'
    click_on I18n.t('devise.sessions.log_in')
    expect(page).to have_content I18n.t('devise.failure.not_found_in_database')
  end

  it 'logs out' do
    user = FactoryBot.create(:user)
    login_as(user)
    visit '/'
    find('.fa-gears').click
    click_on 'Wyloguj'
    expect(page).to have_content I18n.t('devise.sessions.before')
  end
end