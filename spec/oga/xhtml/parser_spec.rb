require 'spec_helper'

describe Oga::XHTML::Parser do
  describe 'Allow XML + HTML entities' do
    before :all do
      @node = Oga.parse_xhtml('<html xmlns:test="http://example.com/"><test:link>foo</test:link><link/><p>&lsquo;bar&rsquo;</p></html>').children[0]
    end

    it 'allows custom namespaces' do
      @node.xpath('//test:link').length.should == 1

      @node.xpath('//link').length.should == 2
    end

    it 'allows elements that would be empty in html' do
      @node.at_xpath('//test:link').text.should == 'foo'
	end
	
    it 'allows html entities' do
      @node.at_xpath('//p').text.should == "\u2018bar\u2019"
    end
  end
end
