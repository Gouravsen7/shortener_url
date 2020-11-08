require 'rails_helper'

RSpec.describe FetchTitleJob, type: :job do
  
  describe "#perform" do
    it "should fetch title" do
      expect {
        FetchTitleJob.perform_later({})
      }.to have_enqueued_job
    end

    it 'queues the job' do
      expect { FetchTitleJob.perform_later({}) }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'is in default queue' do
      expect(FetchTitleJob.new.queue_name).to eq('default')
    end
  end
end
