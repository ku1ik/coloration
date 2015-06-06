require 'test_helper'

describe Object do

  describe '#blank?' do
    it { Object.new.blank?.must_equal(false) }
  end

  describe '#try' do
    context 'when the object responds to the method' do
      it { ''.try(:blank?).must_equal(true) }
    end

    context 'when the object does not respond to the method' do
      it { ''.try(:not_a_method?).must_equal(nil) }
    end
  end

end # Object

describe String do

  describe '#blank?' do
    context 'when the string is blank' do
      it { ''.blank?.must_equal(true) }
    end

    context 'when the string is not blank' do
      it { 'not blank'.blank?.must_equal(false) }
    end
  end

end # String

describe NilClass do

  describe '#blank?' do
    it { nil.blank?.must_equal(true) }
  end

end # NilClass

describe FalseClass do

  describe '#to_i' do
    it { false.to_i.must_equal(0) }
  end

end # FalseClass

describe TrueClass do

  describe '#to_i' do
    it { true.to_i.must_equal(1) }
  end

end # TrueClass
