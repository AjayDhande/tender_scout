require 'rails_helper'

describe FavouriteMonitor do

  #assoc
  it { should belong_to(:user) }
  it { should belong_to(:search_monitor) }

  #validates
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:search_monitor) }

end