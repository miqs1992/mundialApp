require 'rails_helper'

RSpec.describe 'User management', :type => :system do
    it 'allows user to change profile info' do
        user = FactoryBot.create(:user)
        login_as(user)
        visit '/'
        find('.fa-gears').click
        click_on 'Edytuj konto'
        expect(page.current_path).to eq edit_user_registration_path
        fill_in 'user[login]', :with => 'newlogin'
        fill_in 'user[current_password]', :with => user.password
        click_on 'Zaktualizuj'
        expect(user.reload.login).to eq 'newlogin'
    end

    it 'requires current_password' do
        user = FactoryBot.create(:user)
        login_as(user)
        visit '/'
        find('.fa-gears').click
        click_on 'Edytuj konto'
        fill_in 'user[login]', :with => 'newlogin'
        click_on 'Zaktualizuj'
        expect(page).to have_content I18n.t('errors.messages.blank')
        expect(user.reload.login).not_to eq 'newlogin'
    end

    it 'allows to create users by admin' do
        admin = FactoryBot.create(:user, :admin)
        login_as(admin)
        visit new_user_path
        fill_in 'user[login]', :with => 'userlogin'
        fill_in 'user[first_name]', :with => 'Name'
        fill_in 'user[last_name]', :with => 'Surname'
        fill_in 'user[email]', :with => 'example@example.com'
        expect{click_on 'Utwórz konto'}.to change{User.count}.by(1)
    end

    it 'does not allow normal user to access' do
        user = FactoryBot.create(:user)
        login_as(user)
        visit new_user_path
        expect(page.current_path).to eq root_path
        expect(page).to have_content I18n.t('errors.messages.access_denied')
        visit users_path
        expect(page.current_path).to eq root_path
        expect(page).to have_content I18n.t('errors.messages.access_denied')
        expect(page).not_to have_css("i.fa-user-circle-o")
    end

    it 'has all links', :js => true do
        admin = FactoryBot.create(:user, :admin)
        login_as(admin)
        visit '/'
        find('i.fa-user-circle-o').click
        expect(page.current_path).to eq users_path
        click_on 'Utwórz'
        expect(page.current_path).to eq new_user_path
    end
end