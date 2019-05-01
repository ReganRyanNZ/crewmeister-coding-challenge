require_relative "../cm_challenge/absences"
require "icalendar"

RSpec.describe "Absences" do
  describe "to_ical" do
    subject { CmChallenge::Absences.new.to_ical }
    it "returns an ical object" do
      expect(subject.class).to eq(Icalendar::Calendar)
    end

    it "includes all events in ical object" do
      expect(subject.events.count).to eq(42)
    end

    it "includes correct data in events" do
      expect(subject.events.first.summary).to eq("Mike is sick")
      expect(subject.events.first.description).to eq("")
      expect(subject.events.first.dtstart.to_s).to eq("2017-01-13")
      expect(subject.events.first.dtend.to_s).to eq("2017-01-13")

      expect(subject.events.last.summary).to eq("Manuel is on vacation")
      expect(subject.events.last.description).to eq("Manuel's note: Pfadfindersommerlager")
      expect(subject.events.last.dtstart.to_s).to eq("2017-08-05")
      expect(subject.events.last.dtend.to_s).to eq("2017-08-12")
    end
  end

end
