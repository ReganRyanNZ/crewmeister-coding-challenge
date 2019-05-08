require_relative "./api"
require "icalendar"

module CmChallenge
  class Absences

    def initialize filters={}
      @absences = CmChallenge::Api.absences
      @members = CmChallenge::Api.members

      filter_users(filters["userId"]) if filters["userId"].present?
      filter_start_dates(filters["startDate"]) if filters["startDate"].present?
      filter_end_dates(filters["endDate"]) if filters["endDate"].present?
    end

    def to_ical
      cal = Icalendar::Calendar.new
      @absences.each do |absence|
        member = @members.find { |member| member[:user_id] == absence[:user_id] }
        cal.event do |e|
          e.dtstart     = Icalendar::Values::Date.new(absence[:start_date].gsub("-", ""))
          e.dtend       = Icalendar::Values::Date.new(absence[:end_date].gsub("-", ""))
          e.summary     = absence_summary(absence[:type], member[:name])
          e.description = absence_description(absence[:member_note], member[:name])
          e.ip_class    = "PRIVATE"
        end
      end
      cal.publish
      cal
    end

    private

    def filter_users user_id
      @absences = @absences.select{ |a| a[:user_id] == user_id.to_i }
      @members = @members.select{ |m| m[:user_id] == user_id.to_i }
    end

    def filter_start_dates filter_date
      @absences = @absences.select { |a| a[:end_date] >= filter_date }

      @absences = @absences.each do |a|
        a[:start_date] = [a[:start_date], filter_date].max
      end
    end

    def filter_end_dates filter_date
      @absences = @absences.select { |a| a[:start_date] <= filter_date }

      @absences = @absences.each do |a|
        a[:end_date] = [a[:end_date], filter_date].min
      end
    end

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
