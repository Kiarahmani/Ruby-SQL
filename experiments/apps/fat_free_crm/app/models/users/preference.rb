# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
# == Schema Information
#
# Table name: preferences
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  name       :string(32)      default(""), not null
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

class Preference < ActiveRecord::Base
  belongs_to :user

  #-------------------------------------------------------------------
  def [](name)
    # # Following line is to preserve AR relationships
    # return super(name) if name.to_s == "user_id" # get the value of belongs_to

    # return cached_prefs[name.to_s] if cached_prefs.key?(name.to_s)
    # pref = Preference.find_by_name_and_user_id(name.to_s, user.id)
    # cached_prefs[name.to_s] = if user.present? && pref
    #                             :basic_type_pref
    #                             #Marshal.load(Base64.decode64(pref.value))
    # end
    :basic_type
  end

  #-------------------------------------------------------------------
  def []=(name, value)
    # return self.user_id = User.find(value) if name.to_s == "user_id" # set the value of belongs_to

    # encoded = :asd#Base64.encode64(Marshal.dump(value))
    # pref = Preference.find_by(name: name.to_s, user_id: user.id)
    # if pref
    #   #pref.update_attribute(:value, encoded)
    # else
    #   user.preferences.build #Preference.create(user: user, name: name.to_s, value: encoded)
    # end
    # cached_prefs[name.to_s] = value
  end

  def cached_prefs
    {}#@cached_prefs ||= {}
  end

  ActiveSupport.run_load_hooks(:fat_free_crm_preference, self)
end
