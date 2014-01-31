require 'card/content'

class Card::Content
  PURPLE_ATTR = 'data-purple'
  PURPLE_TAGS = %w{
    i b pre caption strong em ol ul li p div h1 h2 h3 h4 h5 h6 span
    table tr td th tfoot }.to_set.freeze

  PURPLE_TAGS.each {|k|
    ALLOWED_TAGS[k] << PURPLE_ATTR
  }

  class << self

    ## Method that cleans the String of HTML tags
    ## and attributes outside of the allowed list.

    # this has been hacked for wagn to allow classes if
    # the class begins with "w-"
    def clean!( string, tags = ALLOWED_TAGS, purple=false )
      string.gsub( /<(\/*)(\w+)([^>]*)>/ ) do
        raw = $~
        tag = raw[2].downcase
        if attrs = tags[tag]
          "<#{raw[1]}#{
            attrs.inject([tag]) do |pcs, attr|
              q='"'
              rest_value=nil
              if raw[3] =~ /\b#{attr}\s*=\s*(?=(.))/i
                rest_value = $'
                idx = %w{' "}.index($1) and q = $1
                re = ATTR_VALUE_RE[ idx || 2 ]
                if match = rest_value.match(re)
                  rest_value = match[0]
                  if attr == 'class'
                    rest_value = rest_value.split(/\s+/).find_all {|s| s=~/^w-/i}*' '
                  end
                end
              end
              rest_value = PurpleNumber.new if purple && rest_value.blank? && attr == PURPLE_ATTR
              pcs << "#{attr}=#{q}#{rest_value}#{q}" unless rest_value.blank?
              pcs
            end * ' '
          }>"
        else
          " "
        end
      end.gsub(/<\!--.*?-->/, '')
    end
  end
end

def purple?; true end
