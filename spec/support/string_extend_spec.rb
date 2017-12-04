describe 'String' do

  describe "#titleize" do

    it "capitalizes each word in a string" do
      expect("to be or not to be".titleize).to eq "To Be Or Not To Be"
    end

    it "works with single-word strings" do
      expect("mississippi".titleize).to eq "Mississippi"
    end

    it "capitalizes all uppercase strings" do
      expect("HOLY COW!".titleize).to eq "Holy Cow!"
    end

    it "capitalizes mixed-case strings" do
      expect("toTaLLy MiXeD cASe".titleize).to eq "Totally Mixed Case"
    end

  end

  describe '#blank?' do

    it "returns true if string is empty" do
      expect("").to be_blank
    end

    it "returns true if string contains only spaces" do
      expect(" ".blank?).to be true
    end

    it "returns true if string contains only tabs" do
      expect("\t\t\t".blank?).to eq true
    end
    # Get a tab using a double-quoted string with \t
    # example: "\t\t\t"

    it "returns true if string contains only spaces and tabs" do
      expect("  \t   \t   ".blank?).to eq true
    end

    it "returns false if string contains a letter" do
      expect("x".blank?).to be_falsey
    end

    it "returns false if string contains a number" do
      expect("9".blank?).to eq false
    end

  end

end
