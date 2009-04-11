require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  def setup
    @richmond = Address.create('city' => 'Richmond', 'state' => 'VA')
    @nashville = Address.create('city' => 'Nashville', 'state' => 'TN')
    @atlanta_attributes = { 'city' => 'Atlanta', 'state' => 'GA' }
    @shipment = Shipment.create
  end

  test 'assigning richmond id to empty shipment' do
    @shipment.update_attributes(:address_id => @richmond.id)
    assert_equal @richmond, @shipment.address
  end

  test 'assigning atlanta attributes to empty shipment' do
    @shipment.update_attributes(:address_attributes => @atlanta_attributes)
    assert_equal @atlanta_attributes.merge('id' => 3), @shipment.address.attributes
  end
end
