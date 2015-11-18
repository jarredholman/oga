module Oga
  module XHTML
    # Parser for processing XHTML input. This parser is a small wrapper around
    # {Oga::XML::Parser} and takes care of setting the various options required
    # for parsing HTML documents.
    #
    # A basic example:
    #
    #     Oga::HTML::Parser.new('<meta charset="utf-8">').parse
    class Parser < XML::Parser
      # @param [String|IO] data
      # @param [Hash] options
      # @see [Oga::XML::Parser#initialize]
      def initialize(data, options = {})
        super(data, options)
      end
	  
      # @param [Array] children
      # @return [Oga::XML::Document]
      def on_document(children = [])
        document = Oga::XML::Document.new(:type => :xhtml)
     
        children.each do |child|
          if child.is_a?(Oga::XML::Doctype)
            document.doctype = child
     
          elsif child.is_a?(Oga::XML::XmlDeclaration)
            document.xml_declaration = child
     
          else
            document.children << child
          end
        end
     
        document
      end

    end # Parser
  end # HTML
end # Oga
