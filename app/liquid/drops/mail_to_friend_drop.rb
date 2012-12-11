class MailToFriendDrop < Cms::BaseDrop # Liquid::Drop
  liquid_attributes << :message << :subject << :sender_name << :sender_email << :recipient_name << :recipient_email << :recipients
end