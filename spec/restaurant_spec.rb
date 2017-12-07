require 'restaurant'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:crescent) { Restaurant.new(:name => 'Crescent', :cuisine => 'paleo', :price => '321') }

  describe 'attributes' do

    it "allow reading and writing for :name" do
      # subject is implicitly Restaurant.new
      subject.name = "Doe's Eat Place"
      expect(subject.name).to eq "Doe's Eat Place"

      expect(crescent.name).to eq "Crescent"
      expect(crescent.name = "CR").to eq "CR"
    end

    it "allow reading and writing for :cuisine" do
      expect(crescent.cuisine).to eq "paleo"
      expect(crescent.cuisine = "atkins").to eq "atkins"
    end

    it "allow reading and writing for :price" do
      expect(crescent.price).to eq "321"
      expect(crescent.price = "123").to eq "123"
    end

  end

  describe '.load_file' do

    it 'does not set @@file if filepath is nil' do
      no_output { Restaurant.load_file(nil) }
      expect(Restaurant.file).to be_nil
    end

    it 'sets @@file if filepath is usable' do
      no_output { Restaurant.load_file(test_file) }
      expect(Restaurant.file).not_to be_nil
      expect(Restaurant.file.class).to be(RestaurantFile)
      expect(Restaurant.file).to be_usable
    end

    it 'outputs a message if filepath is not usable' do
      expect do
        Restaurant.load_file(nil)
      end.to output(/not usable/).to_stdout
    end

    it 'does not output a message if filepath is usable' do
      expect do
        Restaurant.load_file(test_file)
      end.not_to output.to_stdout
    end

  end

  describe '.all' do

    it 'returns array of restaurant objects from @@file' do
      Restaurant.load_file(test_file)
      restaurants = Restaurant.all
      expect(restaurants.class).to eq(Array)
      expect(restaurants.length).to eq(6)
      expect(restaurants.first.class).to eq(Restaurant)
    end

    it 'returns an empty array when @@file is nil' do
      no_output { Restaurant.load_file(nil) }
      restaurants = Restaurant.all
      expect(restaurants).to eq([])
    end

  end

  describe '#initialize' do

    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      it 'sets a default of "" for :name' do
        expect(no_options.name).to be_blank
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(no_options.cuisine).to eq "unknown"
      end

      it 'does not set a default for :price' do
        expect(no_options.price).to be_nil
      end
    end

    context 'with custom options' do

      it 'allows setting the :name' do
        expect(crescent.name).to eq "Crescent"
      end

      it 'allows setting the :cuisine' do
        expect(crescent.cuisine).to eq "paleo"
      end

      it 'allows setting the :price' do
        expect(crescent.price).to eq "321"
      end

    end

  end

  describe '#save' do

    it 'returns false if @@file is nil' do
      # clear the @@file in case random test loads test_file in another test
      @@file = nil # my solution addition to account for random tests

      expect(Restaurant.file).to be_nil # Skoglund solution
      expect(subject.save).to be false # Skoglund used :crescent
    end

    it 'returns false if not valid' do
      Restaurant.load_file(test_file) # Skoglund solution
      expect(Restaurant.file).not_to be_nil # Skoglund solution
      expect(subject.save).to be false # Skoglund solution

      expect(subject.valid?).to eq false # my solution, not like Skoglund's -- probably belongs in '#valid?'
    end

    it 'calls append on @@file if valid' do # Skoglund solution
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      # message expectation on partial test double
      # we're passing in the :crescent object as `self` to be appended onto @@file, which was previously loaded per `let`
      expect(Restaurant.file).to receive(:append).with(crescent)
      crescent.save
    end

  end

  describe '#valid?' do

    it 'returns false if name is nil' do
      subject.name = nil
      expect(subject.valid?).to eq false
    end

    it 'returns false if name is blank' do
      subject.name.clear
      expect(subject.valid?).to eq false
    end

    it 'returns false if cuisine is nil' do
      subject.cuisine = nil
      expect(subject.valid?).to eq false
    end

    it 'returns false if cuisine is blank' do
      subject.cuisine.clear
      expect(subject.valid?).to eq false
    end

    it 'returns false if price is nil' do
      subject.price = nil
      expect(subject.valid?).to eq false
    end

    it 'returns false if price is 0' do
      subject.price = 0
      expect(subject.valid?).to eq false
    end

    it 'returns false if price is negative' do
      subject.price = -1
      expect(subject.valid?).to eq false
    end

    it 'returns true if name, cuisine, price are present' do
      subject.name = "Sloppy Joe's"
      subject.cuisine = "Sandwiches"
      subject.price = "9.99"
      expect(subject.valid?).to eq true
    end

  end

end
