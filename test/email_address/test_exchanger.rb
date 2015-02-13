#encoding: utf-8
require 'extensions/all'
require_relative '../test_helper'

class TestExchanger < MiniTest::Test
  def test_exchanger
    a = EmailAddress::Exchanger.new("example.com")
    assert_equal true, a.has_dns_a_record? # example.com has no MX'ers
  end

  def test_dns
    good = EmailAddress::Exchanger.new("gmail.com")
    bad  = EmailAddress::Exchanger.new("exampldkeie4iufe.com")
    assert_equal true, good.has_dns_a_record?
    assert_equal false, bad.has_dns_a_record?
    assert_equal "gmail.com", good.dns_a_record.first
    assert(/google.com\z/, good.mxers.first.first)
    assert_equal 'google.com', good.domains.first
  end
end
