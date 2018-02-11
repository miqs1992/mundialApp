require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "init password" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.init_password_email(user, "fakeToken") }

    it "renders the headers" do
      expect(mail.subject).to eq('Nowe konto w Mundial App')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["#{ENV.fetch('GMAIL_USERNAME')}@gmail.com"])
    end

    it "renders the body with links" do
      expect(mail.body.encoded).to include(edit_user_password_url(user, reset_password_token: "fakeToken"))
      expect(mail.body.encoded).to include(new_user_password_url)
    end

    it 'sends init password email' do
      expect {
        perform_enqueued_jobs do
          UserMailer.init_password_email(user, "fakeToken").deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
  
  it 'sends init password email to the right user' do
      perform_enqueued_jobs do
        UserMailer.init_password_email(user, "fakeToken").deliver_later
      end
  
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user.email
  end
  end
end
