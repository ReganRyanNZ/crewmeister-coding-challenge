RSpec.describe "Absences ical", type: :request do

  before { get '/' }

  it "is successful" do
    expect(response).to have_http_status(:success)
  end

  it "returns an ics file" do
    expect(response.headers["Content-Type"]).to eq("text/calendar")
    expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"absences.ics\"")
  end
end
