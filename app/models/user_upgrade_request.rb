class UserUpgradeRequest < ApplicationRecord
  belongs_to :user
  after_save :notify_admins

  private
  def notify_admins
  	admin_emails = User.where(role: :admin).pluck :email

  	admin_emails.each do |admin_email|
  		CustomPostmarkMailer.template_email(
        admin_email,
        Rails.configuration.mailer['templates']['user_upgrade_request'],
        {
          user_name: self.user.try(:profiles).try(:first).try(:fullname),
          action_url: 'TODO',
          product_url: Rails.configuration.mailer['product_url'],
          support_url: Rails.configuration.mailer['support'],
          company_name: Rails.configuration.mailer['company_name'],
          company_address: Rails.configuration.mailer['company_address']
        }
      ).deliver_later
  	end
  end
end
