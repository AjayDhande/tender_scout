module UserTenderStatusChanger

def user_read_tender(user,tender)
  user_status =  ::Marketplace::UserTenderStatus.find_by(user_id: user.id, tender_id: tender.id)
  unless user_status.present?
    user_status = ::Marketplace::UserTenderStatus.create(user_id: user.id, tender_id: tender.id, status: 'read')
  end
end

def user_qualifying_tender(user,tender)
  user_status = ::Marketplace::UserTenderStatus.find_by(user_id: user.id, tender_id: tender.id)
  if user_status.status == 'read'
    user_status.update(status: 'qualifying')
  end
end

def user_competing_tender(tender,collaboration)
  users_status = ::Marketplace::UserTenderStatus.where(tender_id: tender, collaboration_id: collaboration).where.not(status: 'competing')
  users_status.each do |user|
    break if user.status == 'awaiting_result' || user.status == 'won_lost'
    user.update(status: 'competing')
  end
end

def user_won_lost_tender(collaboration)
  users_status = ::Marketplace::UserTenderStatus.where(collaboration_id: collaboration).where.not(status: 'won_lost')
  users_status.each do |user|
    user.update(status: 'won_lost')
  end
end

def add_collaboration_to_user_status(user,tender, collaboration)
  user_status = ::Marketplace::UserTenderStatus.find_by(user_id: user.id, tender_id: tender.id)
  unless user_status.present?
    same_collaboration_status = Marketplace::UserTenderStatus.where(collaboration_id: collaboration.id).first.status
    user_status = ::Marketplace::UserTenderStatus.create(user_id: user.id, tender_id: tender.id,
                                                         status: same_collaboration_status)
  end
  user_status.collaboration_id = collaboration.id
  user_status.save
end

end