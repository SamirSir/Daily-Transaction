class ReportsController < ApplicationController
  include ReportsHelper
  before_action :set_group, only: [:notifications]
  before_action :authenticate_user!, except: [:index]
  require 'will_paginate/array'

  def index
    quote_by_user = Profile.all.map { |p| p.bio }
    default_quotes = [
      'Creativity is great but not in accounting.',
      ' To be successful, you should concentrate on the world of companies not arcane accounting mathematics.',
      'Life is like accounting, everything must be balanced.',
      ' Behind every good businessman, there is a great accountant.',
      'There are 3 types of accountant those who can count and those that cant',
      'To multoply the years and divide by the desire to live is a kind of false accounting.'
    ]
    @quotes = quote_by_user | default_quotes
    @quotes = @quotes.shuffle[0, 6]
  end

  def notifications
    @best_incomer = max_of('INCOMES', @group.id)
    @worst_incomer = min_of('INCOMES', @group.id)

    @best_saver = max_of('SAVINGS', @group.id)
    @worst_saver = min_of('SAVINGS', @group.id)

    @best_loaner = min_of('LOANS', @group.id)
    @worst_loaner = max_of('LOANS', @group.id)

    @best_expenser = min_of('EXPENSES', @group.id)
    @worst_expenser = max_of('EXPENSES', @group.id)

    @notices = {
      'Best Incomer' => @best_incomer,
      'Worst Incomer' => @worst_incomer,
      'Best Saver' => @best_saver,
      'Worst Saver' => @worst_saver,
      'Best Loaner' => @best_loaner,
      'Worst Loaner' => @worst_loaner,
      'Best Expenser' => @best_expenser,
      'Worst Expenser' => @worst_expenser
    }

    @notices = @notices.to_a.paginate(page: params[:page], per_page: 2)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
