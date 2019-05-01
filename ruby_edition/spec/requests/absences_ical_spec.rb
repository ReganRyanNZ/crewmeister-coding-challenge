RSpec.describe "Absences ical", type: :request do

  context "with no filters" do
    before { get "/" }

    it "is successful" do
      expect(response).to have_http_status(200)
    end

    it "returns an ics file" do
      expect(response.headers["Content-Type"]).to eq("text/calendar")
      expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"absences.ics\"")
    end

    it "contains all information" do
      expect(response.body.scan(/SUMMARY:/).count).to eq(42)
    end
  end

  context "with user id param" do
    before { get "/", params: {userId: 2664} }

    it "contains all information for that user only" do
      expect(response.body.scan(/SUMMARY:/).count).to eq(10)
      expect(response.body.scan(/SUMMARY:Mike/).count).to eq(10)
    end
  end

  context "with start and end date params" do
    before { get "/", params: {startDate: "2017-02-14", endDate: "2017-04-01"} }

    it "contains absences only in that time frame" do
      expect(response.body.scan(/SUMMARY:/).count > 0).to be true
      expect(
        response.body.scan(/DATE:\d{8}/).all? do |date_str|
          date = date_str[/\d+/]
          date > "20170214" && date < "20170401"
        end
      ).to be true
    end
  end
end
