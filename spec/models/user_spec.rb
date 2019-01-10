require 'rails_helper'

describe User do

  #assoc
  it { should have_many :profiles }
  it { should have_many :search_monitors }
  it { should have_many :favourite_monitors }
  it { should have_many(:tenders).through(:tender_collaborators) }

end