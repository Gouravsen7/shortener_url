require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  

  describe "Validation" do
    
    it "has a valid factory" do
      build(:short_url).should be_valid
    end
    
    it { should validate_presence_of(:original_url) }

    it { should validate_length_of(:original_url).is_at_least(3).is_at_most(255) }
    
  end

  describe "Callbacks" do


    context "when created" do
      subject { build(:short_url) }

      it "should have run generate_short_url" do
        subject.slug = nil
        subject.run_callbacks :create
        expect(subject.slug).not_to be(nil)
      end
    end

     context "when created" do
      subject { build(:short_url, original_url: "https://www.google.com   ") }

      it "should have sanitize original_url" do
        subject.original_url = "https://www.google.com   "
        subject.sanitize
        expect(subject.original_url).to eq("http://google.com")
      end
    end
  end

end
