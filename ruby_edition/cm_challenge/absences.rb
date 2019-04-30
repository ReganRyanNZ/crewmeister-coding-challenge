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
