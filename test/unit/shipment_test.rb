require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  def setup
    @durham = Address.create('city' => 'Durham', 'state' => 'NC')
    @richmond = Address.create('city' => 'Richmond', 'state' => 'VA')
    @nashville = Address.create('city' => 'Nashville', 'state' => 'TN')
    @atlanta_attributes = { 'city' => 'Atlanta', 'state' => 'GA' }
    @shipment = Shipment.create
  end

  # address_id 
  # address_attributes without id
  # on an empty shipment
  # address_attributes wins, creates a new address
  test 'assigning richmond id, atlanta attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @atlanta_attributes
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_id empty
  # address_attributes without id
  # on an empty shipment
  # address_attributes wins, creates a new address
  test 'assigning empty id, atlanta attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = ''
    hash['address_attributes'] = @atlanta_attributes
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_attributes without id
  # address_id 
  # on an empty shipment
  # address_attributes wins, creates a new address
  test 'assigning atlanta attributes, richmond id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @atlanta_attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_attributes without id
  # address_id empty
  # on an empty shipment
  # address_attributes wins, creates a new address
  test 'assigning atlanta attributes, empty id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @atlanta_attributes
    hash['address_id'] = ''
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_id
  # address_attributes with id
  # on an empty shipment
  # address_id wins
  test 'assigning richmond id, nashville attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @nashville.attributes
    @shipment.update_attributes(hash)
    assert_equal @richmond, @shipment.address
  end

  # address_id empty
  # address_attributes with id
  # on an empty shipment
  # empty address wins
  # FIXME
  test 'assigning empty id, nashville attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = ''
    hash['address_attributes'] = @nashville.attributes
    @shipment.update_attributes(hash)
    assert_nil @shipment.address
  end

  # address_attributes with id
  # address_id
  # on an empty shipment
  # address_id wins
  test 'assigning nashville attributes, richmond id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @nashville.attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @richmond, @shipment.address
  end

  # address_attributes with id
  # address_id empty
  # on an empty shipment
  # address_id wins
  #FIXME
  test 'assigning nashville attributes, empty id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @nashville.attributes
    hash['address_id'] = ''
    @shipment.update_attributes(hash)
    assert_nil @shipment.address
  end

  # address_id
  # address_attributes without id
  # on a shipment with another id
  # address_attributes wins, creates new address
  test 'assigning richmond id, atlanta attributes to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @atlanta_attributes
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_id empty
  # address_attributes without id
  # on a shipment with another id
  # address_attributes wins, creates new address
  test 'assigning empty id, atlanta attributes to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = ''
    hash['address_attributes'] = @atlanta_attributes
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_attributes without id
  # address_id
  # on a shipment with another id
  # address_attributes wins, creates new address
  test 'assigning atlanta attributes, richmond id to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @atlanta_attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_attributes without id
  # address_id empty
  # on a shipment with another id
  # address_attributes wins, creates new address
  test 'assigning atlanta attributes, empty id to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @atlanta_attributes
    hash['address_id'] = ''
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 4), @shipment.address.attributes
  end

  # address_id
  # address_attributes with id
  # on a shipment with another id
  # address_id wins
  test 'assigning richmond id, nashville attributes to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @nashville.attributes
    @shipment.update_attributes(hash)
    assert_equal @shipment.address, @richmond
  end

  # address_id empty
  # address_attributes with id
  # on a shipment with another id
  # nil address
  test 'assigning empty id, nashville attributes to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = ''
    hash['address_attributes'] = @nashville.attributes
    @shipment.update_attributes(hash)
    assert_nil @shipment.address
  end

  # address_attributes with id
  # address_id
  # on a shipment with another id
  # another id wins
  # FIXME
  test 'assigning nashville attributes, richmond id to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @nashville.attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @shipment.address, @durham
  end

  # address_attributes with id
  # address_id empty
  # on a shipment with another id
  # another id wins
  # FIXME
  test 'assigning nashville attributes, empty id to durham shipment' do
    @shipment.update_attribute('address_id', @durham.id)
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @nashville.attributes
    hash['address_id'] = ''
    @shipment.update_attributes(hash)
    assert_equal @shipment.address, @durham
  end

end
