require_relative './api'
require 'icalendar'

module CmChallenge
  class Absences
    def to_ical
      @absences = CmChallenge::Api.absences
      @members = CmChallenge::Api.members

      cal = Icalendar::Calendar.new
      @absences.each do |absence|
        member = @members.find { |member| member[:user_id] == absence[:user_id] }
        cal.event do |e|
          e.dtstart     = Icalendar::Values::Date.new(absence[:start_date].gsub('-', ''))
          e.dtend       = Icalendar::Values::Date.new(absence[:end_date].gsub('-', ''))
          e.summary     = absence_summary(absence[:type], member[:name])
          e.description = absence_description(absence[:member_note], member[:name])
          e.ip_class    = "PRIVATE"
        end
      end
      cal.publish
      cal
    end

    private

    def absence_description member_note, name
      member_note.empty? ? "" : "#{name}'s note: #{member_note}"
    end

    def absence_summary type, name
      case type
      when "vacation"
        "#{name} is on vacation"
      when "sickness"
        "#{name} is sick"
      else
        "#{name} is absent"
      end
    end
  end
end

# {:admitter_id=>nil
#   :admitter_note=>""
#   :confirmed_at=>"2017-04-11T08:24:06.000+02:00"
#   :created_at=>"2017-04-09T21:17:12.000+02:00"
#   :crew_id=>352
#   :end_date=>"2017-04-26"
#   :id=>4471
#   :member_note=>"bitte den urlaub in der vorwoche  17-21 zurückziehen. merci :)"
#   :rejected_at=>nil
#   :start_date=>"2017-04-24"
#   :type=>"vacation"
#   :user_id=>2796}