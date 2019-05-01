require_relative '../../cm_challenge/absences'

class AbsencesController < ApplicationController

  def ical
    cal = CmChallenge::Absences.new(ical_params).to_ical
    send_data cal.to_ical, filename: "absences.ics"
  end

  private

  def ical_params
    params.permit(:userId, :startDate, :endDate).to_hash
  end
end