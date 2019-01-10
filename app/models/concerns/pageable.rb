module Pageable
  extend ActiveSupport::Concern

  included do
    def self.my_paginate(params)
      page(params[:page].to_i).per(params[:page_size].to_i)
    end
  end
end