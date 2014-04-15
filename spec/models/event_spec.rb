require 'spec_helper'

describe Event do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @event = Event.new(name: "Cool event", description: "My cool event",
                       user_id: user.id, start_at: DateTime.now,
                       end_at: DateTime.now + 1.hour)
  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user) }
  it { should respond_to(:start_at) }
  it { should respond_to(:end_at) }

  it { should be_valid }
end
