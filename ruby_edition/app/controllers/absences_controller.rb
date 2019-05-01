require_relative '../../cm_challenge/absences'

class AbsencesController < ApplicationController

  def ical
    cal = CmChallenge::Absences.new.to_ical
    send_data cal.to_ical, filename: "absences.ics"
  end

end