class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV.fetch('GMAIL_USERNAME')}@gmail.com"
  layout 'mailer'
end
