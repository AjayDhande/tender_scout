class AddOriginTables < ActiveRecord::Migration[5.1]
  def change
    create_table "core_additional_information", force: :cascade do |t|
      t.string   "title",      limit: 255,  null: false
      t.string   "url",        limit: 4096, null: false
      t.integer  "tender_id",               null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "core_additional_information", ["tender_id"], name: "index_core_additional_information_on_tender_id", using: :btree
    add_index "core_additional_information", ["title"], name: "index_core_additional_information_on_title", using: :btree

    create_table "core_awards", force: :cascade do |t|
      t.string  "lot_title",       limit: 4096,                          null: false
      t.string  "lot_number",      limit: 255
      t.date    "awarded_on",                                            null: false
      t.string  "contract_number", limit: 255
      t.integer "offers_count"
      t.decimal "value",                        precision: 16, scale: 2
      t.integer "tender_id",                                             null: false
      t.integer "organization_id",                                       null: false
      t.integer "contact_id"
    end

    add_index "core_awards", ["contact_id"], name: "index_core_awards_on_contact_id", using: :btree
    add_index "core_awards", ["organization_id"], name: "index_core_awards_on_organization_id", using: :btree
    add_index "core_awards", ["tender_id"], name: "index_core_awards_on_tender_id", using: :btree

    create_table "core_categories", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_categories", ["code"], name: "index_core_categories_on_code", using: :btree

    create_table "core_cities", force: :cascade do |t|
      t.string   "name",       limit: 255
      t.integer  "country_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "core_cities", ["country_id"], name: "index_core_cities_on_country_id", using: :btree
    add_index "core_cities", ["name"], name: "index_core_cities_on_name", using: :btree

    create_table "core_classification_codes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_classification_codes", ["code"], name: "index_core_classification_codes_on_code", using: :btree

    create_table "core_comments", force: :cascade do |t|
      t.text     "commentary",         null: false
      t.integer  "creator_id",         null: false
      t.integer  "analyzed_tender_id", null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "core_contacts", force: :cascade do |t|
      t.string   "phone",           limit: 255
      t.string   "fax",             limit: 255
      t.string   "address",         limit: 4096
      t.string   "email",           limit: 255
      t.string   "contact_point",   limit: 255
      t.string   "city_name",       limit: 255
      t.integer  "region_id"
      t.integer  "organization_id",                             null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "postcode",        limit: 255
      t.boolean  "delta",                        default: true, null: false
      t.integer  "creator_id"
      t.string   "linked_in",       limit: 255
      t.string   "salesforce_id",   limit: 255
      t.string   "assistant",       limit: 255
      t.string   "asst_phone",      limit: 255
      t.string   "department",      limit: 255
      t.string   "description",     limit: 255
      t.boolean  "do_not_call"
      t.boolean  "email_opt_out"
      t.boolean  "fax_opt_out"
      t.string   "lead_source",     limit: 255
      t.string   "mobile",          limit: 255
      t.string   "title",           limit: 255
      t.string   "other_address",   limit: 255
      t.string   "other_phone",     limit: 255
    end

    add_index "core_contacts", ["organization_id"], name: "index_core_contacts_on_organization_id", using: :btree
    add_index "core_contacts", ["region_id"], name: "index_core_contacts_on_region_id", using: :btree

    create_table "core_countries", force: :cascade do |t|
      t.string  "code",            limit: 255
      t.string  "number",          limit: 255,              null: false
      t.string  "alpha2code",      limit: 255,              null: false
      t.string  "alpha3code",      limit: 255,              null: false
      t.string  "name",            limit: 255,              null: false
      t.string  "world_region",    limit: 255,              null: false
      t.string  "world_subregion", limit: 255,              null: false
      t.string  "other_names",     limit: 255, default: [],              array: true
      t.integer "currency_id"
      t.integer "world_region_id"
    end

    add_index "core_countries", ["alpha2code"], name: "index_core_countries_on_alpha2code", using: :btree
    add_index "core_countries", ["alpha3code"], name: "index_core_countries_on_alpha3code", using: :btree
    add_index "core_countries", ["code"], name: "index_core_countries_on_code", using: :btree
    add_index "core_countries", ["currency_id"], name: "index_core_countries_on_currency_id", using: :btree
    add_index "core_countries", ["name", "alpha2code"], name: "index_core_countries_on_name_and_alpha2code", using: :btree
    add_index "core_countries", ["name", "alpha3code"], name: "index_core_countries_on_name_and_alpha3code", using: :btree
    add_index "core_countries", ["name"], name: "index_core_countries_on_name", using: :btree
    add_index "core_countries", ["number"], name: "index_core_countries_on_number", using: :btree
    add_index "core_countries", ["other_names"], name: "index_core_countries_on_other_names", using: :gin
    add_index "core_countries", ["world_region_id"], name: "index_core_countries_on_world_region_id", using: :btree

    create_table "core_cpvs", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_cpvs", ["code"], name: "index_core_cpvs_on_code", using: :btree

    create_table "core_currencies", force: :cascade do |t|
      t.string "name", limit: 255, null: false
      t.string "code", limit: 255, null: false
      t.string "unit", limit: 255
    end

    add_index "core_currencies", ["code"], name: "index_core_currencies_on_code", unique: true, using: :btree
    add_index "core_currencies", ["name"], name: "index_core_currencies_on_name", using: :btree

    create_table "core_documents", force: :cascade do |t|
      t.string   "title",      limit: 255,  null: false
      t.string   "url",        limit: 4096, null: false
      t.integer  "tender_id",               null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "core_documents", ["tender_id"], name: "index_core_documents_on_tender_id", using: :btree
    add_index "core_documents", ["title"], name: "index_core_documents_on_title", using: :btree

    create_table "core_gsin_codes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_gsin_codes", ["code"], name: "index_core_gsin_codes_on_code", using: :btree

    create_table "core_naicses", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_naicses", ["code"], name: "index_core_naicses_on_code", using: :btree

    create_table "core_ngip_codes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_ngip_codes", ["code"], name: "index_core_ngip_codes_on_code", using: :btree

    create_table "core_nhs_e_classes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 300, null: false
    end

    add_index "core_nhs_e_classes", ["code"], name: "index_core_nhs_e_classes_on_code", using: :btree

    create_table "core_nigp_codes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_nigp_codes", ["code"], name: "index_core_nigp_codes_on_code", using: :btree

    create_table "core_organizations", force: :cascade do |t|
      t.string   "name",                    limit: 4096,                               null: false
      t.text     "description"
      t.string   "profile_url",             limit: 4096
      t.string   "web_url",                 limit: 4096
      t.integer  "country_id",                                                         null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "published_tenders_count",                             default: 0,    null: false
      t.integer  "awarded_tenders_count",                               default: 0,    null: false
      t.integer  "awards_count",                                        default: 0,    null: false
      t.boolean  "delta",                                               default: true, null: false
      t.string   "email",                   limit: 255
      t.string   "address",                 limit: 4096
      t.string   "city_name",               limit: 255
      t.string   "phone",                   limit: 255
      t.string   "fax",                     limit: 255
      t.integer  "region_id"
      t.integer  "creator_id"
      t.string   "salesforce_id",           limit: 255
      t.string   "salesforce_number",       limit: 255
      t.string   "salesforce_source",       limit: 255
      t.decimal  "salesforce_revenue",                   precision: 18
      t.integer  "employees"
      t.string   "industry",                limit: 255
      t.string   "ownership",               limit: 255
      t.string   "rating",                  limit: 255
      t.string   "sic_description",         limit: 255
      t.string   "sic_code",                limit: 255
      t.string   "salesforce_type",         limit: 255
      t.string   "ticker_symbol",           limit: 255
    end

    add_index "core_organizations", ["country_id"], name: "index_core_organizations_on_country_id", using: :btree
    add_index "core_organizations", ["name", "country_id", "creator_id"], name: "index_core_organizations_on_name_and_country_id_and_creator_id", unique: true, using: :btree
    add_index "core_organizations", ["name"], name: "index_core_organizations_on_name", using: :btree
    add_index "core_organizations", ["region_id"], name: "index_core_organizations_on_region_id", using: :btree

    create_table "core_pro_classes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 300, null: false
    end

    add_index "core_pro_classes", ["code"], name: "index_core_pro_classes_on_code", using: :btree

    create_table "core_procedures", force: :cascade do |t|
      t.string "name", limit: 255, null: false
    end

    add_index "core_procedures", ["name"], name: "index_core_procedures_on_name", unique: true, using: :btree





    create_table "core_sfgov_codes", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_sfgov_codes", ["code"], name: "index_core_sfgov_codes_on_code", using: :btree

    create_table "core_tenders", force: :cascade do |t|
      t.string   "title",                          limit: 4096,                                          null: false
      t.text     "description"
      t.date     "published_on",                                                                         null: false
      t.date     "awarded_on"
      t.datetime "submission_datetime",                                                                  null: false
      t.date     "deadline_date"
      t.date     "cancelled_on"
      t.integer  "procedure_id",                                                                         null: false
      t.integer  "currency_id",                                                                          null: false
      t.integer  "organization_id",                                                                      null: false
      t.integer  "status_cd",                                                                            null: false
      t.string   "contract_authority_type",        limit: 255
      t.string   "main_activity",                  limit: 255
      t.string   "contract_category",              limit: 255
      t.string   "location",                       limit: 255
      t.boolean  "flagged_as_sme_friendly",                                              default: false, null: false
      t.boolean  "flagged_as_vcs_friendly",                                              default: false, null: false
      t.string   "nuts_codes",                     limit: 255,                           default: [],                 array: true
      t.string   "supplementary_codes",            limit: 255,                           default: [],                 array: true
      t.integer  "contract_duration_in_days"
      t.integer  "contract_duration_in_months"
      t.integer  "contract_duration_in_years"
      t.date     "contract_start_date"
      t.date     "contract_end_date"
      t.decimal  "award_value",                                 precision: 16, scale: 2
      t.decimal  "lowest_offer_value",                          precision: 16, scale: 2
      t.decimal  "highest_offer_value",                         precision: 16, scale: 2
      t.integer  "offers_count"
      t.decimal  "estimated_value",                             precision: 16, scale: 2
      t.decimal  "estimated_low_value",                         precision: 16, scale: 2
      t.decimal  "estimated_high_value",                        precision: 16, scale: 2
      t.integer  "framework_duration_in_days"
      t.integer  "framework_duration_in_months"
      t.integer  "framework_duration_in_years"
      t.decimal  "framework_estimated_value",                   precision: 16, scale: 2
      t.numrange "framework_estimated_low_value"
      t.numrange "framework_estimated_high_value"
      t.string   "keywords",                       limit: 255,                           default: [],                 array: true
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "award_published_on"
      t.date     "potential_retender_date"
      t.string   "tender_urls",                    limit: 255,                           default: [],    null: false, array: true
      t.string   "award_urls",                     limit: 255,                           default: [],    null: false, array: true
      t.integer  "spider_id"
      t.boolean  "delta",                                                                default: true,  null: false
      t.string   "file_reference_number",          limit: 255
      t.integer  "creator_id"
      t.integer  "naics_code_id"
      t.integer  "classification_code_id"
      t.string   "salesforce_id",                  limit: 255
      t.string   "expected_revenue",               limit: 255
      t.string   "forecast_category",              limit: 255
      t.string   "last_modified_by",               limit: 255
      t.string   "lead_source",                    limit: 255
      t.string   "next_step",                      limit: 255
      t.string   "private",                        limit: 255
      t.string   "probability",                    limit: 255
      t.string   "quantity",                       limit: 255
      t.string   "stage",                          limit: 255
      t.string   "salesforce_type",                limit: 255
      t.string   "industry",                       limit: 255
      t.string   "partner",                        limit: 255
      t.boolean  "primary"
      t.string   "role",                           limit: 255
      t.string   "competitor",                     limit: 255
      t.string   "strengths",                      limit: 255
      t.string   "weaknesses",                     limit: 255
      t.string   "set_aside",                      limit: 255
      t.string   "archiving_policy",               limit: 255
      t.date     "archive_date"
      t.string   "original_set_aside",             limit: 255
      t.datetime "awarded_at"
      t.string   "place_of_performance",           limit: 1000
      t.boolean  "request_awards",                                                       default: false
      t.boolean  "retender_status",                                                      default: false
    end

    add_index "core_tenders", ["organization_id"], name: "index_core_tenders_on_organization_id", using: :btree
    add_index "core_tenders", ["procedure_id"], name: "index_core_tenders_on_procedure_id", using: :btree
    add_index "core_tenders", ["spider_id"], name: "index_core_tenders_on_spider_id", unique: true, using: :btree
    add_index "core_tenders", ["title"], name: "index_core_tenders_on_title", using: :btree

    create_table "core_tenders_categories", force: :cascade do |t|
      t.integer "tender_id",   null: false
      t.integer "category_id", null: false
    end

    add_index "core_tenders_categories", ["category_id", "tender_id"], name: "index_core_tenders_categories_on_category_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_categories", ["category_id"], name: "index_core_tenders_categories_on_category_id", using: :btree
    add_index "core_tenders_categories", ["tender_id", "category_id"], name: "index_core_tenders_categories_on_tender_id_and_category_id", unique: true, using: :btree
    add_index "core_tenders_categories", ["tender_id"], name: "index_core_tenders_categories_on_tender_id", using: :btree

    create_table "core_tenders_contacts", force: :cascade do |t|
      t.integer "tender_id",  null: false
      t.integer "contact_id", null: false
    end

    add_index "core_tenders_contacts", ["contact_id", "tender_id"], name: "index_core_tenders_contacts_on_contact_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_contacts", ["contact_id"], name: "index_core_tenders_contacts_on_contact_id", using: :btree
    add_index "core_tenders_contacts", ["tender_id", "contact_id"], name: "index_core_tenders_contacts_on_tender_id_and_contact_id", unique: true, using: :btree
    add_index "core_tenders_contacts", ["tender_id"], name: "index_core_tenders_contacts_on_tender_id", using: :btree

    create_table "core_tenders_cpvs", force: :cascade do |t|
      t.integer "tender_id", null: false
      t.integer "cpv_id",    null: false
    end

    add_index "core_tenders_cpvs", ["cpv_id", "tender_id"], name: "index_core_tenders_cpvs_on_cpv_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_cpvs", ["cpv_id"], name: "index_core_tenders_cpvs_on_cpv_id", using: :btree
    add_index "core_tenders_cpvs", ["tender_id", "cpv_id"], name: "index_core_tenders_cpvs_on_tender_id_and_cpv_id", unique: true, using: :btree
    add_index "core_tenders_cpvs", ["tender_id"], name: "index_core_tenders_cpvs_on_tender_id", using: :btree

    create_table "core_tenders_gsin_codes", force: :cascade do |t|
      t.integer "tender_id", null: false
      t.integer "gsin_id",   null: false
    end

    add_index "core_tenders_gsin_codes", ["gsin_id", "tender_id"], name: "index_core_tenders_gsin_codes_on_gsin_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_gsin_codes", ["gsin_id"], name: "index_core_tenders_gsin_codes_on_gsin_id", using: :btree
    add_index "core_tenders_gsin_codes", ["tender_id", "gsin_id"], name: "index_core_tenders_gsin_codes_on_tender_id_and_gsin_id", unique: true, using: :btree
    add_index "core_tenders_gsin_codes", ["tender_id"], name: "index_core_tenders_gsin_codes_on_tender_id", using: :btree

    create_table "core_tenders_naicses", force: :cascade do |t|
      t.integer "tender_id", null: false
      t.integer "naics_id",  null: false
    end

    add_index "core_tenders_naicses", ["naics_id", "tender_id"], name: "index_core_tenders_naicses_on_naics_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_naicses", ["naics_id"], name: "index_core_tenders_naicses_on_naics_id", using: :btree
    add_index "core_tenders_naicses", ["tender_id", "naics_id"], name: "index_core_tenders_naicses_on_tender_id_and_naics_id", unique: true, using: :btree
    add_index "core_tenders_naicses", ["tender_id"], name: "index_core_tenders_naicses_on_tender_id", using: :btree

    create_table "core_tenders_ngip_codes", force: :cascade do |t|
      t.integer "tender_id",    null: false
      t.integer "ngip_code_id", null: false
    end

    add_index "core_tenders_ngip_codes", ["ngip_code_id", "tender_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_ngip_codes", ["ngip_code_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id", using: :btree
    add_index "core_tenders_ngip_codes", ["tender_id", "ngip_code_id"], name: "index_core_tenders_ngip_codes_on_tender_id_and_ngip_code_id", unique: true, using: :btree
    add_index "core_tenders_ngip_codes", ["tender_id"], name: "index_core_tenders_ngip_codes_on_tender_id", using: :btree

    create_table "core_tenders_nhs_e_classes", force: :cascade do |t|
      t.integer "tender_id",     null: false
      t.integer "nhs_eclass_id", null: false
    end

    add_index "core_tenders_nhs_e_classes", ["nhs_eclass_id", "tender_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_nhs_e_classes", ["nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id", using: :btree
    add_index "core_tenders_nhs_e_classes", ["tender_id", "nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id_and_nhs_eclass_id", unique: true, using: :btree
    add_index "core_tenders_nhs_e_classes", ["tender_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id", using: :btree

    create_table "core_tenders_nigp_codes", force: :cascade do |t|
      t.integer "tender_id",    null: false
      t.integer "nigp_code_id", null: false
    end

    add_index "core_tenders_nigp_codes", ["nigp_code_id", "tender_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_nigp_codes", ["nigp_code_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id", using: :btree
    add_index "core_tenders_nigp_codes", ["tender_id", "nigp_code_id"], name: "index_core_tenders_nigp_codes_on_tender_id_and_nigp_code_id", unique: true, using: :btree
    add_index "core_tenders_nigp_codes", ["tender_id"], name: "index_core_tenders_nigp_codes_on_tender_id", using: :btree

    create_table "core_tenders_pro_classes", force: :cascade do |t|
      t.integer "tender_id",    null: false
      t.integer "pro_class_id", null: false
    end

    add_index "core_tenders_pro_classes", ["pro_class_id", "tender_id"], name: "index_core_tenders_pro_classes_on_pro_class_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_pro_classes", ["pro_class_id"], name: "index_core_tenders_pro_classes_on_pro_class_id", using: :btree
    add_index "core_tenders_pro_classes", ["tender_id", "pro_class_id"], name: "index_core_tenders_pro_classes_on_tender_id_and_pro_class_id", unique: true, using: :btree
    add_index "core_tenders_pro_classes", ["tender_id"], name: "index_core_tenders_pro_classes_on_tender_id", using: :btree

    create_table "core_tenders_sfgov_codes", force: :cascade do |t|
      t.integer "tender_id", null: false
      t.integer "sfgov_id",  null: false
    end

    add_index "core_tenders_sfgov_codes", ["sfgov_id", "tender_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_sfgov_codes", ["sfgov_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id", using: :btree
    add_index "core_tenders_sfgov_codes", ["tender_id", "sfgov_id"], name: "index_core_tenders_sfgov_codes_on_tender_id_and_sfgov_id", unique: true, using: :btree
    add_index "core_tenders_sfgov_codes", ["tender_id"], name: "index_core_tenders_sfgov_codes_on_tender_id", using: :btree

    create_table "core_tenders_unspsces", force: :cascade do |t|
      t.integer "tender_id", null: false
      t.integer "unspsc_id", null: false
    end

    add_index "core_tenders_unspsces", ["tender_id", "unspsc_id"], name: "index_core_tenders_unspsces_on_tender_id_and_unspsc_id", unique: true, using: :btree
    add_index "core_tenders_unspsces", ["tender_id"], name: "index_core_tenders_unspsces_on_tender_id", using: :btree
    add_index "core_tenders_unspsces", ["unspsc_id", "tender_id"], name: "index_core_tenders_unspsces_on_unspsc_id_and_tender_id", unique: true, using: :btree
    add_index "core_tenders_unspsces", ["unspsc_id"], name: "index_core_tenders_unspsces_on_unspsc_id", using: :btree

    create_table "core_unspsces", force: :cascade do |t|
      t.string "code",        limit: 255, null: false
      t.string "description", limit: 255, null: false
    end

    add_index "core_unspsces", ["code"], name: "index_core_unspsces_on_code", using: :btree

    create_table "core_user_countries", force: :cascade do |t|
      t.integer "user_id",                           null: false
      t.integer "country_id",                        null: false
      t.integer "number_of_occurrences", default: 0
    end

    create_table "core_world_regions", force: :cascade do |t|
      t.string "code", limit: 255, null: false
      t.string "name", limit: 255, null: false
    end

    add_foreign_key "core_tenders_categories", "core_categories", column: "category_id", name: "core_tenders_categories_category_id_fk", on_delete: :cascade
    add_foreign_key "core_tenders_categories", "core_tenders", column: "tender_id", name: "core_tenders_categories_tender_id_fk", on_delete: :cascade
    add_foreign_key "core_tenders_ngip_codes", "core_ngip_codes", column: "ngip_code_id", name: "core_tenders_ngip_codes_ngip_code_id_fk", on_delete: :cascade
    add_foreign_key "core_tenders_ngip_codes", "core_tenders", column: "tender_id", name: "core_tenders_ngip_codes_tender_id_fk", on_delete: :cascade
    add_foreign_key "core_tenders_nigp_codes", "core_nigp_codes", column: "nigp_code_id", name: "core_tenders_nigp_codes_nigp_code_id_fk", on_delete: :cascade
    add_foreign_key "core_tenders_nigp_codes", "core_tenders", column: "tender_id", name: "core_tenders_nigp_codes_tender_id_fk", on_delete: :cascade
  end
end
