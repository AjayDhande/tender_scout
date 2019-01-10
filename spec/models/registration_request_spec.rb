require 'rails_helper'

describe RegistrationRequest do

  #assoc
  it { should belong_to(:country) }
  it { should belong_to(:industry) }

end