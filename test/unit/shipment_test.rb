require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  def setup
    @richmond = Address.create('city' => 'Richmond', 'state' => 'VA')
    @nashville = Address.create('city' => 'Nashville', 'state' => 'TN')
    @atlanta_attributes = { 'city' => 'Atlanta', 'state' => 'GA' }
    @shipment = Shipment.create
  end

  test 'assigning richmond id to empty shipment' do
    @shipment.update_attributes('address_id' => @richmond.id)
    assert_equal @richmond, @shipment.address
  end

  test 'assigning atlanta attributes to empty shipment' do
    @shipment.update_attributes('address_attributes' => @atlanta_attributes)
    assert_equal @atlanta_attributes.merge('id' => 3), @shipment.address.attributes
  end

  ## address_attributes without id always wins over address_id on an empty shipment

  test 'assigning richmond id, atlanta attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @atlanta_attributes
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 3), @shipment.address.attributes
  end

  test 'assigning atlanta attributes, richmond id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @atlanta_attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @atlanta_attributes.merge('id' => 3), @shipment.address.attributes
  end

  ## address_id always wins over address_attributes with id on an empty shipment

  test 'assigning richmond id, nashville attributes to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_id'] = @richmond.id
    hash['address_attributes'] = @nashville.attributes
    @shipment.update_attributes(hash)
    assert_equal @richmond, @shipment.address
  end

  test 'assigning nashville attributes, richmond id to empty shipment' do
    hash = ActiveSupport::OrderedHash.new
    hash['address_attributes'] = @nashville.attributes
    hash['address_id'] = @richmond.id
    @shipment.update_attributes(hash)
    assert_equal @richmond, @shipment.address
  end
end
