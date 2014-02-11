require 'card/content'

Card::Content

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

protected

# override same method in core, adds purple? test/arg to clean!

def set_content new_content
  if self.id #have to have this to create revision
    new_content ||= ''
    new_content = Card::Content.clean! new_content, nil, purple? if clean_html?
    clear_drafts if current_revision_id
    new_rev = Card::Revision.create :card_id=>self.id, :content=>new_content, :creator_id =>Account.current_id
    self.current_revision_id = new_rev.id
    reset_patterns_if_rule saving=true
    @name_or_content_changed = true
  else
    false
  end
end
