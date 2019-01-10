require 'rails_helper'

describe Core::Tender do

  #assoc
  it { should have_many :documents}
  it { should have_many :additional_information }
  it { should have_many :awards }
  it { should have_many :tender_collaborators}
  it { should have_many :tender_contacts }
  it { should have_many :tender_cpvs }
  it { should have_many :tender_ngips }
  it { should have_many :tender_categories }
  it { should have_many :tender_nhs_e_classes }
  it { should have_many :tender_pro_classes }
  it { should have_many :tender_naicses }
  it { should have_many(:contacts).through(:tender_contacts) }
  it { should have_many(:cpvs).through(:tender_cpvs) }
  it { should have_many(:naicses).through(:tender_naicses) }
  it { should have_many(:ngips).through(:tender_ngips) }
  it { should have_many :tender_unspsces }
  it { should have_many(:gsins).through(:tender_gsins) }
  it { should have_many(:categories).through(:tender_categories) }
  it { should have_many(:nhs_e_classes).through(:tender_nhs_e_classes) }
  it { should have_many(:pro_classes).through(:tender_pro_classes) }
  it { should have_many(:tender_collaborators) }
  it { should belong_to(:currency) }
  it { should belong_to(:industry) }
  it { should belong_to(:organization) }
  it { should belong_to(:procedure) }
  it { should belong_to(:classification) }

end