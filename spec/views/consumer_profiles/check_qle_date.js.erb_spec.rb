require 'rails_helper'

describe "consumer_profiles/check_qle_date.js.erb" do
  let(:qle) {FactoryGirl.create(:qualifying_life_event_kind)}
  before :each do
    assign :qualified_date, true
    assign :qle, qle
    render file: "consumer_profiles/check_qle_date.js.erb"
  end

  it "should match effective_on_kinds" do
    expect(rendered).to match(/effective_on_kinds/)
  end
end
